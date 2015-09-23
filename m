From: wangsongbo <songbo1227@gmail.com>
Subject: Re: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Thu, 24 Sep 2015 00:50:04 +0800
Message-ID: <5602D83C.5090901@gmail.com>
References: <56027EE3.5080909@gmail.com> <56027F1D.90508@gmail.com>
 <56028812.1050207@dachary.org>
 <alpine.DEB.2.00.1509230611360.11876@cobra.newdream.net>
 <5602C398.7000905@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34908 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbIWQuQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 12:50:16 -0400
Received: by pacfv12 with SMTP id fv12so45908697pac.2
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 09:50:16 -0700 (PDT)
In-Reply-To: <5602C398.7000905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage and Loic,
Thanks for your reply.
I am running teuthology in our testing.I can send a traceroute to=20
64.90.32.37.
but when ceph-cm-ansible run the " yum-complete-transaction=20
--cleanup-only" command,
it got such a response=20
:"http://apt-mirror.front.sepia.ceph.com/misc-rpms/repodata/repomd.xml:=
=20
[Errno 14] PYCURL ERROR 7 - "Failed connect to=20
apt-mirror.front.sepia.ceph.com:80; Connection timed out"
And I replace "apt-mirror.front.sepia.ceph.com"  to "64.90.32.37" in=20
repo file, then run "yum-complete-transaction --cleanup-only" command,
I got a response like=20
this:"http://64.90.32.37/misc-rpms/repodata/repomd.xml: [Errno 14]=20
PYCURL ERROR 22 - "The requested URL returned error: 502 Bad Gateway""
I do not know whether it was affected by the last week's attack.

Thanks and Regards,
WangSongbo

On 15/9/23 =E4=B8=8B=E5=8D=8811:22, Loic Dachary wrote:
>
> On 23/09/2015 15:11, Sage Weil wrote:
>> On Wed, 23 Sep 2015, Loic Dachary wrote:
>>> Hi,
>>>
>>> On 23/09/2015 12:29, wangsongbo wrote:
>>>> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>>> It works for me. Could you send a traceroute
>>> apt-mirror.front.sepia.ceph.com ?
>> This is a private IP internal to the sepia lab.  Anythign outside th=
e lab
>> shouldn't be using it...
> This is the public facing IP and is required for teuthology to run ou=
tside of the lab (http://tracker.ceph.com/issues/12212).
>
> 64.90.32.37 apt-mirror.front.sepia.ceph.com
>
> suggests the workaround was used. And a traceroute will confirm if th=
e resolution happens as expected (with the public IP) or with a private=
 IP (meaning the workaround is not in place where it should).
>
> Cheers
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
