From: Loic Dachary <loic@dachary.org>
Subject: Re: Beta testing crush optimization
Date: Tue, 6 Jun 2017 15:58:08 +0200
Message-ID: <7f860290-f769-a938-8923-916f91adf5c5@dachary.org>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org>
 <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org>
 <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
 <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org>
 <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
 <5c2c692a-99c3-4b33-33bd-b9523943d7a4@dachary.org>
 <CANNfkubHKXhdaF5p2kOxfhTe-W3H=OmyyJ4hM+e10X=UB+rjEg@mail.gmail.com>
 <e7c26a8f-e0cc-ff35-e4ae-6326846a1e02@dachary.org>
 <CANNfkubUEyxupv_fc=X6yNht1enwwjWbwXsX4T=DDHiLeDYkGw@mail.gmail.com>
 <62744992-f6d9-7577-eb84-47c794a5fad4@dachary.org>
 <CANNfkua3j+214FXAJsnW+5Vww-ALN4YWUOERB9hmsiH=tmjZ5w@mail.gmail.com>
 <989c0eab-ab12-074a-be4b-ee7d4c0b63e4@dachary.org>
 <e524e1e8-7845-4ebf-f1eb-7328c4d40316@dachary.org>
 <CANNfkubvjhfV8PCdBD6s043acm5kQEC2y2pQk39wLzbqL325kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54281 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdFFN6M (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 09:58:12 -0400
In-Reply-To: <CANNfkubvjhfV8PCdBD6s043acm5kQEC2y2pQk39wLzbqL325kw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: han vincent <hangzws@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

A new version of python-crush was published (1.0.34), please upgrade to get the fixes. Thanks again for your patience. It's quite interesting to see that although your RGW cluster have many pools, the vast majority of the data is in the rgw.bucket pool alone. It makes it possible to rebalance the cluster simply by rebalancing this pool.

On 06/06/2017 11:02 AM, han vincent wrote:
> Hi, loic:
>    I saw you had published a new version(v1.0.33) of "python crush" .
> And then I test it used my crushmap.
>    I am glad to tell you that the "optimize" command have worked well.
> when I used the following command such as:
> 
>    crush optimize --crushmap report.json --out-path optimized.crush
> --rule replicated_ruleset --pool 49
> 
>    There was no error output anymore. And after that I import the
> optimized crushmap to my cluster, after rebalancing all the OSDs are
> +-0.9 over/under filled.
> 
>    when I used the "compare" command, there was an error in output:
>    crush compare --rule replicated_ruleset --replication-count 2
> --origin /tmp/report.json --destination optimized.crush

You need to specify --destination-choose-args for the optimized crushmap:

$ crush compare --origin /tmp/report.json --pool 49 --destination /tmp/optimized.crush --destination-choose-args 49
There are 2048 PGs.

Replacing the crushmap specified with --origin with the crushmap
specified with --destination will move 75 PGs (3.662109375% of the total)
from one item to another.

The rows below show the number of PGs moved from the given
item to each item named in the columns. The PGs% at the
end of the rows shows the percentage of the total number
of PGs that is moved away from this particular item. The
last row shows the percentage of the total number of PGs
that is moved to the item named in the column.

       osd.0  osd.1  osd.2  osd.3  osd.4  osd.5  osd.6  osd.7  osd.8  osd.9   PGs%
osd.0      0      9      0      0      0      1      0      0      0      1  0.54%
osd.1      0      0      2      5      0      0      1      2      0      1  0.54%
osd.2      0      1      0      1      0      0      0      0      0      0  0.10%
osd.3      0      0      7      0      0      0      0      0      0      0  0.34%
osd.4      2      0      1      3      0      2      0      3      0      0  0.54%
osd.5      2      1      4      0     10      0      0      0      1      1  0.93%
osd.6      0      0      0      0      0      0      0      0      1      0  0.05%
osd.7      0      0      0      2      0      0      7      0      1      0  0.49%
osd.8      1      0      1      0      0      0      0      0      0      1  0.15%
PGs%   0.24%  0.54%  0.73%  0.54%  0.49%  0.15%  0.39%  0.24%  0.15%  0.20%  3.66%

> 
>    Traceback (most recent call last):
>    File "/usr/bin/crush", line 25, in <module>
>     sys.exit(Ceph().main(sys.argv[1:]))
>    File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
>     return self.constructor(argv).run()
>    File "/usr/lib64/python2.7/site-packages/crush/compare.py", line 327, in run
>     self.run_compare()
>    File "/usr/lib64/python2.7/site-packages/crush/compare.py", line
> 332, in run_compare
>     self.set_destination_crushmap(self.args.destination)
>    File "/usr/lib64/python2.7/site-packages/crush/compare.py", line
> 59, in set_destination_crushmap
>     d.parse(self.main.convert_to_crushmap(destination))
>    File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
> line 739, in convert_to_crushmap
>     self.set_compat_choose_args(c, crushmap, choose_args_name)
>    File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
> line 716, in set_compat_choose_args
>     assert choose_args_name
>    AssertionError
> 
>    After that, I got the report of my cluster and "optimize" it once
> again, there still have an error in output:
>   ceph report > report.new.json
>   crush optimize --crushmap report.json --out-path optimized.crush
> --rule replicated_ruleset --pool 49
>   [root@node-4 ~]# crush optimize --crushmap report.json --out-path
> optimized.crush --rule replicated_ruleset --pool 49
> Traceback (most recent call last):
>   File "/usr/bin/crush", line 25, in <module>
>     sys.exit(Ceph().main(sys.argv[1:]))
>   File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
>     return self.constructor(argv).run()
>   File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373, in run
>     crushmap = self.main.convert_to_crushmap(self.args.crushmap)
>   File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
> line 731, in convert_to_crushmap
>     self.set_analyze_args(crushmap)
>   File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
> line 657, in set_analyze_args
>     compat_pool = self.get_compat_choose_args(crushmap)
>   File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
> line 645, in get_compat_choose_args
>     assert 1 == len(crushmap['private']['pools'])
> AssertionError

This bug was fixed in the latest release:

$ crush optimize --crushmap /tmp/report.new.json --pool 49 --out-path /tmp/optimized.crush
2017-06-06 15:23:27,649 argv = optimize --crushmap /tmp/report.new.json --pool 49 --out-path /tmp/optimized.crush --pool=49 --choose-args=49 --replication-count=2 --pg-num=1024 --pgp-num=1024 --rule=replicated_ruleset --out-version=h --no-positions
2017-06-06 15:23:27,672 default optimizing
2017-06-06 15:23:27,804 default already optimized
2017-06-06 15:23:27,809 node-7v optimizing
2017-06-06 15:23:27,809 node-5v optimizing
2017-06-06 15:23:27,812 node-4 optimizing
2017-06-06 15:23:27,813 node-8v optimizing
2017-06-06 15:23:27,816 node-6v optimizing
2017-06-06 15:23:27,989 node-7v already optimized
2017-06-06 15:23:27,991 node-6v already optimized
2017-06-06 15:23:28,026 node-4 already optimized
2017-06-06 15:23:28,554 node-5v already optimized
2017-06-06 15:23:28,556 node-8v already optimized

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
