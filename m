From: han vincent <hangzws@gmail.com>
Subject: Re: Beta testing crush optimization
Date: Tue, 6 Jun 2017 17:02:27 +0800
Message-ID: <CANNfkubvjhfV8PCdBD6s043acm5kQEC2y2pQk39wLzbqL325kw@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org> <CANNfkubxHfAYn-aLkHCQV_YZoMuVTzug9nRbvaTSE4UyKiQLuw@mail.gmail.com>
 <9c4d5c65-4bd3-19e0-2e0e-59331f952c46@dachary.org> <CANNfkuZbfNSW5CQHaV0yyF3744FPf-gh0vKBj45bZKrvZ27MhA@mail.gmail.com>
 <eefdcd45-e6fa-4bf0-56b3-76e155f45de2@dachary.org> <CANNfkuZF219VWnCYYQoPY7CXXBAFq1=BrfOyC_vL7-+nU5ixMg@mail.gmail.com>
 <6721f5e4-4da0-868c-6d65-c180fdb564e0@dachary.org> <CANNfkuY1KfLb=WR2scJKb82RKqGAwUB3wWSrPzvht-=ixsfhGg@mail.gmail.com>
 <5c2c692a-99c3-4b33-33bd-b9523943d7a4@dachary.org> <CANNfkubHKXhdaF5p2kOxfhTe-W3H=OmyyJ4hM+e10X=UB+rjEg@mail.gmail.com>
 <e7c26a8f-e0cc-ff35-e4ae-6326846a1e02@dachary.org> <CANNfkubUEyxupv_fc=X6yNht1enwwjWbwXsX4T=DDHiLeDYkGw@mail.gmail.com>
 <62744992-f6d9-7577-eb84-47c794a5fad4@dachary.org> <CANNfkua3j+214FXAJsnW+5Vww-ALN4YWUOERB9hmsiH=tmjZ5w@mail.gmail.com>
 <989c0eab-ab12-074a-be4b-ee7d4c0b63e4@dachary.org> <e524e1e8-7845-4ebf-f1eb-7328c4d40316@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:35175 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdFFJC2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 05:02:28 -0400
Received: by mail-it0-f42.google.com with SMTP id m62so87226049itc.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 02:02:28 -0700 (PDT)
In-Reply-To: <e524e1e8-7845-4ebf-f1eb-7328c4d40316@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi, loic:
   I saw you had published a new version(v1.0.33) of "python crush" .
And then I test it used my crushmap.
   I am glad to tell you that the "optimize" command have worked well.
when I used the following command such as:

   crush optimize --crushmap report.json --out-path optimized.crush
--rule replicated_ruleset --pool 49

   There was no error output anymore. And after that I import the
optimized crushmap to my cluster, after rebalancing all the OSDs are
+-0.9 over/under filled.

   when I used the "compare" command, there was an error in output:
   crush compare --rule replicated_ruleset --replication-count 2
--origin /tmp/report.json --destination optimized.crush

   Traceback (most recent call last):
   File "/usr/bin/crush", line 25, in <module>
    sys.exit(Ceph().main(sys.argv[1:]))
   File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
    return self.constructor(argv).run()
   File "/usr/lib64/python2.7/site-packages/crush/compare.py", line 327, in run
    self.run_compare()
   File "/usr/lib64/python2.7/site-packages/crush/compare.py", line
332, in run_compare
    self.set_destination_crushmap(self.args.destination)
   File "/usr/lib64/python2.7/site-packages/crush/compare.py", line
59, in set_destination_crushmap
    d.parse(self.main.convert_to_crushmap(destination))
   File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 739, in convert_to_crushmap
    self.set_compat_choose_args(c, crushmap, choose_args_name)
   File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 716, in set_compat_choose_args
    assert choose_args_name
   AssertionError

   After that, I got the report of my cluster and "optimize" it once
again, there still have an error in output:
  ceph report > report.new.json
  crush optimize --crushmap report.json --out-path optimized.crush
--rule replicated_ruleset --pool 49
  [root@node-4 ~]# crush optimize --crushmap report.json --out-path
optimized.crush --rule replicated_ruleset --pool 49
Traceback (most recent call last):
  File "/usr/bin/crush", line 25, in <module>
    sys.exit(Ceph().main(sys.argv[1:]))
  File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in main
    return self.constructor(argv).run()
  File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373, in run
    crushmap = self.main.convert_to_crushmap(self.args.crushmap)
  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 731, in convert_to_crushmap
    self.set_analyze_args(crushmap)
  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 657, in set_analyze_args
    compat_pool = self.get_compat_choose_args(crushmap)
  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py",
line 645, in get_compat_choose_args
    assert 1 == len(crushmap['private']['pools'])
AssertionError
