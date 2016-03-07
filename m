From: Martin Palma <martin@palma.bz>
Subject: Re: (Un)Stable release team
Date: Mon, 7 Mar 2016 14:25:51 +0100
Message-ID: <CANMxC7DW5uF8c_ud8Dwzx1eBg=qr2_c-6eG3NyWvX=DGMwWixw@mail.gmail.com>
References: <56D001C6.5080804@dachary.org> <56DA3514.6060706@dachary.org> <56DD7EF9.1060301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38604 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcCGN0N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 08:26:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so70313085wml.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Mar 2016 05:26:13 -0800 (PST)
In-Reply-To: <56DD7EF9.1060301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

yes it is right. Thank you.

Best,
Martin

On Mon, Mar 7, 2016 at 2:15 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Martin,
>
> Your GPG snippet was integrated in http://ceph-workbench.dachary.org/=
dachary/ceph-workbench/blob/wip-release/ceph_workbench/release.py#L58 a=
nd I added a
> Copyright line at the top of the file http://ceph-workbench.dachary.o=
rg/dachary/ceph-workbench/blob/wip-release/ceph_workbench/release.py#L4=
 . Is it right ?
>
> Cheers
>
> On 05/03/2016 08:23, Loic Dachary wrote:
>> Hi,
>>
>> Here is a draft of the release process for development versions (htt=
p://pad.ceph.com/p/development-releases-draft) which I experimented wit=
h manually. Comment and suggestions are welcome.
>>
>> Cheers
>>
>> On 26/02/2016 14:41, Loic Dachary wrote:
>>> Hi,
>>>
>>> It's a quiet time in the small world of the stable release team, id=
eal for mentoring the new members who generously answered our call for =
participation. Welcome to Chen Xiaoxi, Gaurav Bafna, Wei-Chung Cheng, M=
artin Palma and Chris Jones :-)
>>>
>>> I propose that we take advantage of the next few weeks to expand ou=
r scope in two ways:
>>>
>>> * test Ceph development versions as well as stable versions
>>> * publish packages for Ceph development versions
>>>
>>> Testing Ceph development versions is actually less work than with s=
table versions because the developers run a lot of tests already and fi=
x problems on a daily basis. Our help would likely be needed with a few=
 teuthology suite runs right before the development release is publishe=
d, once a month. But the development versions tend to be more frequent,=
 therefore it will probably be as much work as for a stable release, ov=
erall. The workflow would be revisited: there is no cherry-picking. Ins=
tead, bug fixes must be against the jewel branch or whatever branch wil=
l be the upcoming stable. And this branch is merged back into master on=
 a regular basis (i.e. more frequently than the development releases).
>>>
>>> As you may have noticed, no packages were published for the 10.0.3 =
development release and that's where we could make a real difference. T=
his would be an entirely new part of our workflow, but also an exciting=
 one because it's the last missing piece of the puzzle. Once we are abl=
e to publish usable packages for development releases, nothing is stopp=
ing us to do the same for stable releases. It's a lot easier than it se=
ems since the packages are already built for the teuthology jobs. All w=
e need is a public space to archive them and sign them. This is not mut=
ually exclusive with the current package publication workflow, it would=
 be a community driven alternative that is much needed in some cases.
>>>
>>> Of course, this is easier said than done :-) What do you think ? Ar=
e there other important work that we should try to accomplish instead ?=
 Things that would benefit Ceph users and developers more ?
>>>
>>> Cheers
>>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
