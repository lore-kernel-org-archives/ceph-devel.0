From: Sage Weil <sage@newdream.net>
Subject: Re: [BUG]  ceph 0.23 ,sudo /etc/init.d/init-ceph  cleanalllogs ,
 delete /   folder
Date: Thu, 2 Dec 2010 11:22:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012021121230.1982@cobra.newdream.net>
References: <1291274740.1757.85.camel@cephhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34210 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab0LBTST (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 14:18:19 -0500
In-Reply-To: <1291274740.1757.85.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Wu <cpwu@tnsoft.com.cn>
Cc: "gregf@hq.newdream.net" <gregf@hq.newdream.net>, "yehuda@hq.newdream.net" <yehuda@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>, ceph-devel@vger.kernel.org, mllv <mllv@tnsoft.com.cn>, wchen <wchen@tnsoft.com.cn>

Hi Jeff,

On Thu, 2 Dec 2010, Jeff Wu wrote:
> [...]
> Look into init-ceph codes, should be "$log_sym_dir/* " equal to  "/*",
> "cleanlogs" command also exist this issue. init-ceph script might be add
> a check for "$log_dir" and "$log_sym_dir".

This was updated in the 'rc' branch (soon to be 0.24).  It's now

	cleanlogs)
	    echo removing logs
	    if [ -n "$log_sym_dir" ]; then
		do_cmd "for f in $log_sym_dir/$type.$id.*; do rm -f 
\`readlink \$f\` ; rm -f \$f ; done ; rm -f $log_dir/$type.$id.*"
	    fi
	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/$type.$id.*"
	    ;;

	cleanalllogs)
	    echo removing all logs
	    [ -n "$log_sym_dir" ] && do_cmd "rm -f $log_sym_dir/* || true"
	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/* || true"
	    ;;

> and If we detect some of bugs ,does it update to 
> http://tracker.newdream.net/projects/ceph ?
> 
> if yes ,how ?

Yes, please.  You can create an account, log in, and then click the 'new 
issue' button along the top.  In this case the issue is fixed for the next 
release though (I believe?) so we should be okay.

Thanks!
sage
