From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Wed, 31 May 2017 17:52:35 +0800
Message-ID: <CANNfkuYtWeucakVigP5Hh_HxPztqU54GRVPMMG9BrpqokRyzkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36009 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbdEaJwh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 05:52:37 -0400
Received: by mail-io0-f169.google.com with SMTP id o12so12949687iod.3
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 02:52:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: loic@dachary.org

hello, loic:

I had a cluster build with hammer 0.94.10, then I used the following
commands to change the algorithm from "straw" to "straw2".
1. ceph osd crush tunables hammer
2. ceph osd getcrushmap -o /tmp/cmap
3. crushtool -d /tmp/cmap -o /tmp/cmap.txt
4. vim /tmp/cmap.txt and change the algorithm of each bucket from
"straw" to "straw2"
5. crushtool -c /tmp/cmap.txt -o /tmp/cmap
6. ceph osd setcrushmap -i /tmp/cmap
7. ceph osd crush reweight-all
after that, I used "python crush" to optimize the cluster, the version
of "python crush" is 1.0.32

1. ceph report > report.json
2. crush optimize --crushmap report.json --out-path optimized.crush
Unfortunately, there was an error in the output:

2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
2017-05-30 18:48:01,838 49.3af map to [9, 2] instead of [9, 3]
2017-05-30 18:48:01,838 49.e3 map to [6, 4] instead of [6, 5]
2017-05-30 18:48:01,838 49.e1 map to [7, 2] instead of [7, 3]
2017-05-30 18:48:01,838 49.e0 map to [5, 1] instead of [5, 0]
2017-05-30 18:48:01,838 49.20d map to [3, 1] instead of [3, 0]
2017-05-30 18:48:01,838 49.20c map to [2, 9] instead of [2, 8]
2017-05-30 18:48:01,838 49.36e map to [6, 1] instead of [6, 0]
......

Traceback (most recent call last):
 File "/usr/bin/crush", line 25, in <module>
sys.exit(Ceph().main(sys.argv[1:]))
 File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
return self.constructor(argv).run()
 File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373, in run
crushmap = self.main.convert_to_crushmap(self.args.crushmap)
 File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 690, in convert_to_crushmap
c.parse(crushmap)
 File "/usr/lib64/python2.7/site-packages/crush/__init__.py", line 138, in parse
return self.parse_crushmap(self._convert_to_crushmap(something))
 File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 416, in _convert_to_crushmap
crushmap = CephReport().parse_report(something)
 File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 137, in parse_report
raise MappingError("some mapping failed, please file a bug at "
crush.ceph.MappingError: some mapping failed, please file a bug at
http://libcrush.org/main/python-crush/issues/new
Do you know what the problem is? can you help me? I would be very
grateful to you.
