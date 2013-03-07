From: Greg Farnum <greg@inktank.com>
Subject: Re: changes to rados command
Date: Thu, 7 Mar 2013 12:37:26 -0800
Message-ID: <B48B0643D9BB4AB2A1798C68B52481F7@inktank.com>
References: <20130307192522.0F7C7EAF31@ningd5.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61349 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932753Ab3CGUh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 15:37:29 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so735832pad.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 12:37:29 -0800 (PST)
In-Reply-To: <20130307192522.0F7C7EAF31@ningd5.research.att.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Hume <andrew@ningd5.research.att.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, March 7, 2013 at 11:25 AM, Andrew Hume wrote:
> 
> in order to make the rados command more useful in scripts,
> i'd like to make a change, specifically change to
> 
> rados -p pool getomapval obj key [fmt]
> 
> where fmt is an optional formatting parameter.
> i've implemented 'str' which will print the value as an unadorned string.
> 
> what is the process for doing this?
> 
Patch submission, you mean? Github pull requests, sending a pull request with git URL to the list, or sending straight patches the list are all good. I'll like you more if you give me a URL of some form instead of making me get the patches out of email and into my git repo correctly, though. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


