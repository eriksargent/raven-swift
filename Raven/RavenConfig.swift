//
//  RavenConfig.swift
//  Raven-Swift
//
//  Created by Tommy Mikalsen on 03.09.14.
//

import Foundation

class RavenConfig {
    var serverUrl : NSURL?
    var publicKey : String?
    var secretKey : String?
    var projectId : String?
    
    init() {}
    
    func setDSN(DSN : String) -> Bool {
        let DSNURL = NSURL(string: DSN)
        if DSNURL.host == nil{
            return false
        }
        
        var pathComponents = DSNURL.pathComponents as [String]
        
        if (pathComponents.count == 0)
        {
            println("Missing path")
            return false
        }
        
        pathComponents.removeAtIndex(0) // always remove the first slash
        
        projectId = pathComponents.last // project id is the last element of the path
        
        if projectId == nil{
            return false
        }
        
        pathComponents.removeLast() // remove the project id...
       
        var path = "/".join(pathComponents)  // ...and construct the path again
        
        // Add a slash to the end of the path if there is a path
        if (path != "") {
            path += "/"
        }
        
        var scheme: String = DSNURL.scheme ?? "http"
        
        var port = DSNURL.port
        if (port == nil) {
            if (DSNURL.scheme == "https") {
                port = 443;
            } else {
                port = 80;
            }
        }
        
        serverUrl = NSURL(string:"\(scheme)://\(DSNURL.host!):\(port!)\(path)/api/\(projectId!)/store/")
        publicKey = DSNURL.user
        secretKey = DSNURL.password
    
        return true
    }
}
