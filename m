From: Sage Weil <sage@inktank.com>
Subject: Re: Huge MDS log crashing the cluster
Date: Wed, 23 May 2012 09:03:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205230903090.15923@cobra.newdream.net>
References: <loom.20120522T130047-937@post.gmane.org>
 <CADvuQRFtccEPA4k7X8R-_gGvPzz6Zt13Za1buPjp_5ufY-zk4Q@mail.gmail.com>
 <loom.20120523T122902-865@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38737 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965054Ab2EWQEB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 12:04:01 -0400
In-Reply-To: <loom.20120523T122902-865@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 23 May 2012, Madhusudhana U wrote:
> Tommi Virtanen <tv <at> inktank.com> writes:
> > The default logrotate script installed by ceph.deb rotates log files
> > daily and preserves 7 days of logs. If your /var is tiny, or you have
> > heavy debugging turned on, you probably need to rotate more often and
> > retain fewer log files. Or, if you're not using the debs, you'll need
> > to provide some other means of rotating the log files.
> 
> In order to log rotate, we need to stop the deamon accessing the log file 
> and them rename it right? I have removed the log file using rm command to 
> check whether it will release the space, but even after the file removal, 
> my /var partition is still full. 
> 
> So, do I have to stop MDS deamon and then remove the log file ? i am not 
> finding any command through which i can stop MDS on node. Can you please
> let me know how i can safely stop the MDS and then start it back ?

1. rename the file
2. send SIGHUP to the daemon and it will reopen (/create a new file)

sage
