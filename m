From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Better debug log levels for autotest jobs
Date: Wed, 27 Apr 2011 16:38:09 -0700
Message-ID: <912A0CC1B20144A289E9EE1C0E1418A3@gmail.com>
References: <20110427232516.GB6405@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34067 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760333Ab1D0XiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 19:38:12 -0400
Received: by pzk9 with SMTP id 9so1329869pzk.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 16:38:12 -0700 (PDT)
In-Reply-To: <20110427232516.GB6405@dreamer>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Looking at what we have here, we are unlikely to need:
auth, paxos, monc
above 5 (or probably 1). The code these run is pretty stable and hasn't exhibited significant issues in a long time IIRC.
Unfortunately the MDS is one we're likely to want to keep high, but I suppose that with debug mds 10 if there are problems we can probably at least get an idea of what they are and then re-run tests with more debugging.
Similarly with the OSDS...we definitely don't need debug osd 25, though I'm not sure that turning it down to 20 would do much anyway.

Probably just turn 20 to 10 like you said, except the ones I mentioned above. These tests are easy to reproduce with higher debugging if needed.
-Greg
On Wednesday, April 27, 2011 at 4:25 PM, Tommi Virtanen wrote:
Hi. Our autotest runs log just way too much debug stuff. A 20-minute
> run often creates >10GB uncompressed data. That's enough that
> compressing & transporting it for archival slows down the test
> significantly.
> 
> Ceph devs, I need your help in determining what debug logs can be
> turned down a notch or two without losing anything really valuable.
> 
> The base config is at ceph-autotests.git teuthology/ceph.conf,
> relevant lines pasted below:
> 
> [mon]
>  lockdep = 1
>  debug mon = 20
>  debug paxos = 20
>  debug auth = 20
>  debug ms = 1
> 
> [osd]
>  lockdep = 1
>  debug ms = 1
>  debug osd = 25
>  debug monc = 20
>  debug journal = 20
>  debug filestore = 20
> 
> [mds]
>  lockdep = 1
>  debug ms = 1
>  debug mds = 20
>  debug auth = 20
>  debug monc = 20
>  mds debug scatterstat = true
>  mds verify scatter = true
>  mds log max segments = 2
>  mds cache size = 10000
>  mds debug frag = true
> 
> What can I turn down? If I don't get helpful suggestions, everything
> 20 goes down to 10 ;)
> 
> 
> The worst that happens if we have the defaults not include some debug
> you wanted see is you make your test override it and re-run; for
> example,
> 
> class ceph_dbench(skeleton.CephTest):
>  ...
>  @skeleton.role('client')
>  def init_025_moar_debug(self):
>  self.ceph_conf['osd']['debug osd'] = 9000
> 
> should do it just fine.
> 
> (We can make that even easier, if it becomes commonplace enough. My
> motto is to first feel the pain. YAGNI and all that.)
> 
> -- 
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

