From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [Cbt] Ceph Community Lab: Understanding where the QA suites spend
 time
Date: Wed, 19 Aug 2015 17:08:48 -0500
Message-ID: <55D4FE70.9010400@redhat.com>
References: <55D4DD24.9010100@redhat.com> <55D4FD99.6000508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbHSWIv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Aug 2015 18:08:51 -0400
In-Reply-To: <55D4FD99.6000508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com

I have no idea about the price of cloud computing services, but if you 
can find setups that give you access to SSDs you may be able to run 
through thrasher tests much faster (cheaper?). :)

Mark

On 08/19/2015 05:05 PM, Loic Dachary wrote:
> Hi,
>
> To help put things in perspective (please forgive me if it's a fact already known to everyone), > 95% of the teuthology jobs can run on virtual machines with 8GB RAM, 40GB disk, 2 processors and no attached disks. The cost of running such virtual machines in the cloud currently is 0.033 euros per hour. Running 40 teuthology jobs at all times would require an average of 80 such virtual machines (most jobs use 2 machines, some 1 or 3), that is 0.033 * 80 vms * 24 hours * 31 days == ~2000 euros per month (also note that at least one cloud provider offers 50% discount if such virtual machines are reserved full time). That's 3 to 6 times cheaper than AWS.
>
> I'm not sure how much it costs to run these 40 teuthology jobs on a hand made lab but I'd be surprised if it was cheaper, all included. Whatever hardware already exists in the sepia lab can easily handle the remaining 5% of jobs that require actual hardware for one reason or the other.
>
> My 3.3cts ;-)
>
> On 19/08/2015 21:46, Mark Nelson wrote:
>> Hi Guys,
>>
>> About a month ago we were going through the process of trying to figure out how to replace some of the hardware in the community laboratory that runs all of the nightly Teuthology tests.  Given a limited budget to replace the existing nodes, we wanted to understand how the current QA suites actually spend time on the hardware.  To do this, we investigated the composition of suites, the amount of time that is spent in each suite, and then a deeper dive into how the most resource intensive jobs spend their time.  We then wrote a new benchmark for CBT to run ceph-test-rados in a rather naive reproduction of what the ceph task in teuthology does and tested it against several different storage device configurations to see how much benefit SSDs in the nodes may provide.
>>
>> A couple of folks at the Hackathon were interested in the paper we wrote.  I thought I would share it with the community as well in case any folks ever wondered what Teuthology actually spends it's time doing.
>>
>> http://nhm.ceph.com/community/Ceph_Community_Lab_Performance_Investigation.pdf
>>
>> Thanks,
>> Mark
>> _______________________________________________
>> Cbt mailing list
>> Cbt@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
>
