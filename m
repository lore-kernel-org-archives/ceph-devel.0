From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph unit test help
Date: Fri, 24 Feb 2017 19:07:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702241907090.7782@piezo.novalocal>
References: <CAK=B8ybPatezCJvb_5kYWKEQbPVyJAU12KP0rCkdjafC4+s6LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50898 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbdBXTHm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 14:07:42 -0500
In-Reply-To: <CAK=B8ybPatezCJvb_5kYWKEQbPVyJAU12KP0rCkdjafC4+s6LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Muminul Islam Russell <misla011@fiu.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 24 Feb 2017, Muminul Islam Russell wrote:
> Hello cephers,
> 
> 
> I am new this ceph development although have been using it for long
> time. At first I started building and followed the same steps
> described the the github.
> 
> ./do_cmake.sh
> cd build
> make
> 
> I changed some code in ceph-detect init and added proper test cases as
> well but the test cased failed.
> 
> Could you please suggest me what is going wrong here?

I think the python pieces are somewhat special.  You might try 'make 
tests' and then try it again?

sage


> 
> sudo ctest --output-on-failure -R run-tox-ceph-detect-init
> Test project /home/muislam/ceph_upstream/ceph/build
>     Start 15: run-tox-ceph-detect-init
> 1/1 Test #15: run-tox-ceph-detect-init .........***Failed    0.25 sec
> /home/muislam/ceph_upstream/ceph/src/ceph-detect-init/run-tox.sh: line
> 30: /tmp/ceph-detect-init-virtualenv/bin/activate: No such file or
> directory
> Traceback (most recent call last):
>   File "/bin/tox", line 9, in <module>
>     load_entry_point('tox==1.4.2', 'console_scripts', 'tox')()
>   File "/usr/lib/python2.7/site-packages/tox/_cmdline.py", line 24, in main
>     config = parseconfig(args, 'tox')
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 23, in
> parseconfig
>     parseini(config)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 170, in __init__
>     config)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 223, in
> _makeenvconfig
>     for depline in reader.getlist(section, "deps"):
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 296, in getlist
>     s = self.getdefault(section, name, None)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 389, in
> getdefault
>     x = self._replace(x)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 489, in _replace
>     return rexpattern.sub(self._sub, x)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 402, in _sub
>     (key, envkey))
> tox.ConfigError: ConfigError: substitution 'env:NO_INDEX:':
> 'NO_INDEX:' not found in environment
> 
> 
> 0% tests passed, 1 tests failed out of 1
> 
> Total Test time (real) =   0.31 sec
> 
> The following tests FAILED:
>      15 - run-tox-ceph-detect-init (Failed)
> Errors while running CTest
> 
> Thanks in advance.
> 
> Best,
> Muminul
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
