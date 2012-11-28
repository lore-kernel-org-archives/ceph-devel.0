From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Wed, 28 Nov 2012 10:51:57 -0800
Message-ID: <50B65D4D.7020804@inktank.com>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag> <50B543A9.1080901@inktank.com> <50B5C6C9.1020303@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57402 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730Ab2K1SwB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 13:52:01 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so9929370pbc.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 10:52:01 -0800 (PST)
In-Reply-To: <50B5C6C9.1020303@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Dan Mick <dan.mick@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/28/2012 12:09 AM, Stefan Priebe - Profihost AG wrote:
> Am 27.11.2012 23:50, schrieb Josh Durgin:
>> On 11/27/2012 01:16 AM, Stefan Priebe - Profihost AG wrote:
>>> Am 26.11.2012 21:00, schrieb Dan Mick:
>>>> As for fstrim: on the rbd image?....sure, if it's a filesystem, it
>>>> ought
>>>> to work (modulo some bugs I've heard about with 32-bit vs. 64-bit
>>>> offsets in qemu... :) )
>>> it works fine with my patches i send to qemu. But right now they're no
>>> upstream an nobody of the qemu people answers anymore. So right now i'll
>>> keep my patches and be lucky others can't use RBD and fstrim. So maybe
>>> inktank should push this a bit more to the qemu people.
>>
>> If you could send another version with PATCHv3 instead of PATCH in the
>> subject, and a description of the changes since the last version between
>> the --- and the diffstat, the qemu folks would probably appreciate it.
>
> No idea how to archieve this with git send-email ;-( But still more
> important is also the patch for discards...

Use git format-patch, edit the patch file (it includes the basic
headers already), then send it with git send-email.

Your return value type change was already merged into master of
qemu.git as 08448d5195aeff49bf25fb62b4a6218f079f5284.

Josh
