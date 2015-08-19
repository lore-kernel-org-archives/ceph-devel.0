From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: [Cbt] Ceph Community Lab: Understanding where the QA suites
 spend time
Date: Wed, 19 Aug 2015 18:36:38 -0400 (EDT)
Message-ID: <1706639434.6541467.1440023798853.JavaMail.zimbra@redhat.com>
References: <55D4DD24.9010100@redhat.com> <55D4FD99.6000508@dachary.org> <55D4FE70.9010400@redhat.com> <55D501B0.40303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:36419 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbHSWhq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 18:37:46 -0400
In-Reply-To: <55D501B0.40303@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com

> The network variance also counts :

Yes, it's quite true. We have to consider of that part.

Shinobu

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.k=
ernel.org>, cbt@lists.ceph.com
Sent: Thursday, August 20, 2015 7:22:40 AM
Subject: Re: [Cbt] Ceph Community Lab: Understanding where the QA suite=
s spend time



On 20/08/2015 00:08, Mark Nelson wrote:> I have no idea about the price=
 of cloud computing services, but if you can find setups that give you =
access to SSDs you may be able to run through thrasher tests much faste=
r (cheaper?). :)

In my experience (~2 month experience, not much really ;-), VMs are twi=
ce slower than bare metal on average (sometime it's only sightly slower=
, sometime it's 3 times slower). The network variance also counts : I'v=
e seen providers take ~20 minutes to install the Ceph packages (it's ~2=
GB altogether).

My 3.3 * ~2 cts ;-)

> Mark
>=20
> On 08/19/2015 05:05 PM, Loic Dachary wrote:
>> Hi,
>>
>> To help put things in perspective (please forgive me if it's a fact =
already known to everyone), > 95% of the teuthology jobs can run on vir=
tual machines with 8GB RAM, 40GB disk, 2 processors and no attached dis=
ks. The cost of running such virtual machines in the cloud currently is=
 0.033 euros per hour. Running 40 teuthology jobs at all times would re=
quire an average of 80 such virtual machines (most jobs use 2 machines,=
 some 1 or 3), that is 0.033 * 80 vms * 24 hours * 31 days =3D=3D ~2000=
 euros per month (also note that at least one cloud provider offers 50%=
 discount if such virtual machines are reserved full time). That's 3 to=
 6 times cheaper than AWS.
>>
>> I'm not sure how much it costs to run these 40 teuthology jobs on a =
hand made lab but I'd be surprised if it was cheaper, all included. Wha=
tever hardware already exists in the sepia lab can easily handle the re=
maining 5% of jobs that require actual hardware for one reason or the o=
ther.
>>
>> My 3.3cts ;-)
>>
>> On 19/08/2015 21:46, Mark Nelson wrote:
>>> Hi Guys,
>>>
>>> About a month ago we were going through the process of trying to fi=
gure out how to replace some of the hardware in the community laborator=
y that runs all of the nightly Teuthology tests.  Given a limited budge=
t to replace the existing nodes, we wanted to understand how the curren=
t QA suites actually spend time on the hardware.  To do this, we invest=
igated the composition of suites, the amount of time that is spent in e=
ach suite, and then a deeper dive into how the most resource intensive =
jobs spend their time.  We then wrote a new benchmark for CBT to run ce=
ph-test-rados in a rather naive reproduction of what the ceph task in t=
euthology does and tested it against several different storage device c=
onfigurations to see how much benefit SSDs in the nodes may provide.
>>>
>>> A couple of folks at the Hackathon were interested in the paper we =
wrote.  I thought I would share it with the community as well in case a=
ny folks ever wondered what Teuthology actually spends it's time doing.
>>>
>>> http://nhm.ceph.com/community/Ceph_Community_Lab_Performance_Invest=
igation.pdf
>>>
>>> Thanks,
>>> Mark
>>> _______________________________________________
>>> Cbt mailing list
>>> Cbt@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
