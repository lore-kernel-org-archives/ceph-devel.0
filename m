From: wangsongbo <songbo1227@gmail.com>
Subject: Re: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Thu, 24 Sep 2015 12:10:13 +0800
Message-ID: <560377A5.7070803@gmail.com>
References: <56027EE3.5080909@gmail.com> <56027F1D.90508@gmail.com>
 <56028812.1050207@dachary.org>
 <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net>
 <5602C398.7000905@dachary.org> <5602D83C.5090901@gmail.com>
 <5602DAE0.4000403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34150 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbIXEKe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 00:10:34 -0400
Received: by padhy16 with SMTP id hy16so60355876pad.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 21:10:34 -0700 (PDT)
In-Reply-To: <5602DAE0.4000403@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Loic, It's my fault. The dns server I set is unreachable. when I modify=
=20
that , everything is ok.

Thanks and Regards,
WangSongbo

On 15/9/24 =E4=B8=8A=E5=8D=881:01, Loic Dachary wrote:
>
> On 23/09/2015 18:50, wangsongbo wrote:
>> Sage and Loic,
>> Thanks for your reply.
>> I am running teuthology in our testing.I can send a traceroute to 64=
=2E90.32.37.
>> but when ceph-cm-ansible run the " yum-complete-transaction --cleanu=
p-only" command,
>> it got such a response :"http://apt-mirror.front.sepia.ceph.com/misc=
-rpms/repodata/repomd.xml: [Errno 14] PYCURL ERROR 7 - "Failed connect =
to apt-mirror.front.sepia.ceph.com:80; Connection timed out"
>> And I replace "apt-mirror.front.sepia.ceph.com"  to "64.90.32.37" in=
 repo file, then run "yum-complete-transaction --cleanup-only" command,
>> I got a response like this:"http://64.90.32.37/misc-rpms/repodata/re=
pomd.xml: [Errno 14] PYCURL ERROR 22 - "The requested URL returned erro=
r: 502 Bad Gateway""
>> I do not know whether it was affected by the last week's attack.
> Querying the IP directly won't get you where the mirror is (it's a vh=
ost). I think ansible fails because it queries the DNS and does not use=
 the entry you set in the /etc/hosts file. The OpenStack teuthology bac=
kend sets a specific entry in the DNS to workaround the problem (see ht=
tps://github.com/ceph/teuthology/blob/master/teuthology/openstack/setup=
-openstack.sh#L318)
>
> Cheers
>
>> Thanks and Regards,
>> WangSongbo
>>
>> On 15/9/23 =E4=B8=8B=E5=8D=8811:22, Loic Dachary wrote:
>>> On 23/09/2015 15:11, Sage Weil wrote:
>>>> On Wed, 23 Sep 2015, Loic Dachary wrote:
>>>>> Hi,
>>>>>
>>>>> On 23/09/2015 12:29, wangsongbo wrote:
>>>>>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>>>> It works for me. Could you send a traceroute
>>>>> apt-mirror.front.sepia.ceph.com ?
>>>> This is a private IP internal to the sepia lab.  Anythign outside =
the lab
>>>> shouldn't be using it...
>>> This is the public facing IP and is required for teuthology to run =
outside of the lab (http://tracker.ceph.com/issues/12212).
>>>
>>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>>
>>> suggests the workaround was used. And a traceroute will confirm if =
the resolution happens as expected (with the public IP) or with a priva=
te IP (meaning the workaround is not in place where it should).
>>>
>>> Cheers
>>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
