From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Wed, 31 May 2017 14:34:55 +0300
Message-ID: <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34532 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdEaLfB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 07:35:01 -0400
In-Reply-To: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han vincent <hangzws@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 05/31/2017 12:32 PM, han vincent wrote:
> hello, loic:
>      
> I had a cluster build with hammer 0.94.10, then I used the following commands to change the algorithm from "straw" to "straw2".
> 1. ceph osd crush tunables hammer
> 2. ceph osd getcrushmap -o /tmp/cmap
> 3. crushtool -d /tmp/cmap -o /tmp/cmap.txt
> 4. vim /tmp/cmap.txt and change the algorithm of each bucket from "straw" to "straw2"
> 5. crushtool -c /tmp/cmap.txt -o /tmp/cmap
> 6. ceph osd setcrushmap -i /tmp/cmap
> 7. ceph osd crush reweight-all
> after that, I used "python crush" to optimize the cluster, the version of "python crush" is 1.0.32
> 
> 1. ceph report > report.json
> 2. crush optimize --crushmap report.json --out-path optimized.crush
> Unfortunately, there was an error in the output:
> 
> 2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
> 2017-05-30 18:48:01,838 49.3af map to [9, 2] instead of [9, 3]
> 2017-05-30 18:48:01,838 49.e3 map to [6, 4] instead of [6, 5]
> 2017-05-30 18:48:01,838 49.e1 map to [7, 2] instead of [7, 3]
> 2017-05-30 18:48:01,838 49.e0 map to [5, 1] instead of [5, 0]
> 2017-05-30 18:48:01,838 49.20d map to [3, 1] instead of [3, 0]
> 2017-05-30 18:48:01,838 49.20c map to [2, 9] instead of [2, 8]
> 2017-05-30 18:48:01,838 49.36e map to [6, 1] instead of [6, 0]
> ......
> 
> Traceback (most recent call last):
>  File "/usr/bin/crush", line 25, in <module>
> sys.exit(Ceph().main(sys.argv[1:]))
>  File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
> return self.constructor(argv).run()
>  File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373, in run
> crushmap = self.main.convert_to_crushmap(self.args.crushmap)
>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 690, in convert_to_crushmap
> c.parse(crushmap)
>  File "/usr/lib64/python2.7/site-packages/crush/__init__.py", line 138, in parse
> return self.parse_crushmap(self._convert_to_crushmap(something))
>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 416, in _convert_to_crushmap
> crushmap = CephReport().parse_report(something)
>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 137, in parse_report
> raise MappingError("some mapping failed, please file a bug at "
> crush.ceph.MappingError: some mapping failed, please file a bug at http://libcrush.org/main/python-crush/issues/new
> Do you know what the problem is? can you help me? I would be very grateful to you.    

This is a safeguard to make sure python-crush maps exactly as expected. I'm not sure yet why there is a difference but I'll work on that, using the crush implementation found in hammer 0.94.10. For your information, the full output of:

$ crush analyze --crushmap /tmp/han-vincent-report.json

is at https://paste2.org/PyeHe2dC What I find strange is that your output regarding pool 42 is different than mine. You have:


2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]

and I have

2017-05-31 12:55:04,207 42.3 map to [4, 3] instead of [4, 2]
2017-05-31 12:55:04,207 42.7 map to [8, 0] instead of [8, 1]
2017-05-31 12:55:04,207 42.1 map to [4, 9] instead of [4, 8]

I wonder if that's a sign that the changes to the crushmap following your change to straw2 are still going on. Would you mind sending me the output of ceph report (please run it again after receiving this mail) ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
