From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Wed, 31 May 2017 15:40:20 +0300
Message-ID: <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39884 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEaMk0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 May 2017 08:40:26 -0400
In-Reply-To: <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han vincent <hangzws@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I found the reason for the map problem, thanks a lot for reporting it. In a nutshell the "stable" tunable was implemented after hammer and your ceph report does not mention it at all. python-crush incorrectly assumes this means it should default to 1. It must default to 0 instead. When I do that manually, all mappings are correct. I'll fix this and publish a new version by tomorrow.

Your cluster is not very unbalanced (less than 10% overfilled):

(virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --crushmap /tmp/han-vincent-report.json --pool 49
         ~id~  ~weight~  ~PGs~  ~over/under filled %~
~name~                                               
node-6v    -4      1.08    427                   4.25
node-4     -2      1.08    416                   1.56
node-7v    -5      1.08    407                  -0.63
node-8v    -6      1.08    405                  -1.12
node-5v    -3      1.08    393                  -4.05

Worst case scenario if a host fails:

        ~over filled %~
~type~                 
device             7.81
host               4.10
root               0.00
(virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --type device --crushmap /tmp/han-vincent-report.json --pool 49
        ~id~  ~weight~  ~PGs~  ~over/under filled %~
~name~                                              
osd.5      5      0.54    221                   7.91
osd.0      0      0.54    211                   3.03
osd.7      7      0.54    210                   2.54
osd.4      4      0.54    206                   0.59
osd.8      8      0.54    206                   0.59
osd.1      1      0.54    205                   0.10
osd.3      3      0.54    200                  -2.34
osd.9      9      0.54    199                  -2.83
osd.6      6      0.54    197                  -3.81
osd.2      2      0.54    193                  -5.76

Worst case scenario if a host fails:

        ~over filled %~
~type~                 
device             7.81
host               4.10
root               0.00

With optimization things will improve:

$ crush optimize --crushmap /tmp/han-vincent-report.json --out-path /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
2017-05-31 15:17:59,917 argv = optimize --crushmap /tmp/han-vincent-report.json --out-path /tmp/han-vincent-report-optimized.txt --out-format txt --pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --out-version=h --no-positions --choose-args=49
2017-05-31 15:17:59,940 default optimizing
2017-05-31 15:18:05,007 default wants to swap 43 PGs
2017-05-31 15:18:05,013 node-6v optimizing
2017-05-31 15:18:05,013 node-4 optimizing
2017-05-31 15:18:05,016 node-8v optimizing
2017-05-31 15:18:05,016 node-7v optimizing
2017-05-31 15:18:05,018 node-5v optimizing
2017-05-31 15:18:05,369 node-4 wants to swap 8 PGs
2017-05-31 15:18:05,742 node-6v wants to swap 10 PGs
2017-05-31 15:18:06,382 node-5v wants to swap 7 PGs
2017-05-31 15:18:06,602 node-7v wants to swap 7 PGs
2017-05-31 15:18:07,346 node-8v already optimized

(virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --choose-args=49
         ~id~  ~weight~  ~PGs~  ~over/under filled %~
~name~                                               
node-4     -2      1.08    410                   0.10
node-5v    -3      1.08    410                   0.10
node-6v    -4      1.08    410                   0.10
node-7v    -5      1.08    409                  -0.15
node-8v    -6      1.08    409                  -0.15

Worst case scenario if a host fails:

        ~over filled %~
~type~                 
device             5.47
host               3.71
root               0.00
(virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --type device --crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --choose-args=49
        ~id~  ~weight~  ~PGs~  ~over/under filled %~
~name~                                              
osd.2      2      0.54    206                   0.59
osd.8      8      0.54    206                   0.59
osd.0      0      0.54    205                   0.10
osd.1      1      0.54    205                   0.10
osd.4      4      0.54    205                   0.10
osd.5      5      0.54    205                   0.10
osd.7      7      0.54    205                   0.10
osd.3      3      0.54    204                  -0.39
osd.6      6      0.54    204                  -0.39
osd.9      9      0.54    203                  -0.88

Worst case scenario if a host fails:

        ~over filled %~
~type~                 
device             5.47

host               3.71
root               0.00

Note that the other pools won't be optimized and their PGs will be moved around for no good reason. However, since they contain very few PGs each (8 for most of them, 32 for one of them) and very little data (less than 1MB total), it won't matter much.

Cheers

On 05/31/2017 02:34 PM, Loic Dachary wrote:
> Hi,
> 
> On 05/31/2017 12:32 PM, han vincent wrote:
>> hello, loic:
>>      
>> I had a cluster build with hammer 0.94.10, then I used the following commands to change the algorithm from "straw" to "straw2".
>> 1. ceph osd crush tunables hammer
>> 2. ceph osd getcrushmap -o /tmp/cmap
>> 3. crushtool -d /tmp/cmap -o /tmp/cmap.txt
>> 4. vim /tmp/cmap.txt and change the algorithm of each bucket from "straw" to "straw2"
>> 5. crushtool -c /tmp/cmap.txt -o /tmp/cmap
>> 6. ceph osd setcrushmap -i /tmp/cmap
>> 7. ceph osd crush reweight-all
>> after that, I used "python crush" to optimize the cluster, the version of "python crush" is 1.0.32
>>
>> 1. ceph report > report.json
>> 2. crush optimize --crushmap report.json --out-path optimized.crush
>> Unfortunately, there was an error in the output:
>>
>> 2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
>> 2017-05-30 18:48:01,838 49.3af map to [9, 2] instead of [9, 3]
>> 2017-05-30 18:48:01,838 49.e3 map to [6, 4] instead of [6, 5]
>> 2017-05-30 18:48:01,838 49.e1 map to [7, 2] instead of [7, 3]
>> 2017-05-30 18:48:01,838 49.e0 map to [5, 1] instead of [5, 0]
>> 2017-05-30 18:48:01,838 49.20d map to [3, 1] instead of [3, 0]
>> 2017-05-30 18:48:01,838 49.20c map to [2, 9] instead of [2, 8]
>> 2017-05-30 18:48:01,838 49.36e map to [6, 1] instead of [6, 0]
>> ......
>>
>> Traceback (most recent call last):
>>  File "/usr/bin/crush", line 25, in <module>
>> sys.exit(Ceph().main(sys.argv[1:]))
>>  File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
>> return self.constructor(argv).run()
>>  File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373, in run
>> crushmap = self.main.convert_to_crushmap(self.args.crushmap)
>>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 690, in convert_to_crushmap
>> c.parse(crushmap)
>>  File "/usr/lib64/python2.7/site-packages/crush/__init__.py", line 138, in parse
>> return self.parse_crushmap(self._convert_to_crushmap(something))
>>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 416, in _convert_to_crushmap
>> crushmap = CephReport().parse_report(something)
>>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", line 137, in parse_report
>> raise MappingError("some mapping failed, please file a bug at "
>> crush.ceph.MappingError: some mapping failed, please file a bug at http://libcrush.org/main/python-crush/issues/new
>> Do you know what the problem is? can you help me? I would be very grateful to you.    
> 
> This is a safeguard to make sure python-crush maps exactly as expected. I'm not sure yet why there is a difference but I'll work on that, using the crush implementation found in hammer 0.94.10. For your information, the full output of:
> 
> $ crush analyze --crushmap /tmp/han-vincent-report.json
> 
> is at https://paste2.org/PyeHe2dC What I find strange is that your output regarding pool 42 is different than mine. You have:
> 
> 
> 2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
> 
> and I have
> 
> 2017-05-31 12:55:04,207 42.3 map to [4, 3] instead of [4, 2]
> 2017-05-31 12:55:04,207 42.7 map to [8, 0] instead of [8, 1]
> 2017-05-31 12:55:04,207 42.1 map to [4, 9] instead of [4, 8]
> 
> I wonder if that's a sign that the changes to the crushmap following your change to straw2 are still going on. Would you mind sending me the output of ceph report (please run it again after receiving this mail) ?
> 
> Cheers
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
