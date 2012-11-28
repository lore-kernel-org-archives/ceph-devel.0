From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Wed, 28 Nov 2012 09:09:45 +0100
Message-ID: <50B5C6C9.1020303@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag> <50B543A9.1080901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50208 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2K1IJv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 03:09:51 -0500
In-Reply-To: <50B543A9.1080901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.11.2012 23:50, schrieb Josh Durgin:
> On 11/27/2012 01:16 AM, Stefan Priebe - Profihost AG wrote:
>> Am 26.11.2012 21:00, schrieb Dan Mick:
>>> As for fstrim: on the rbd image?....sure, if it's a filesystem, it ought
>>> to work (modulo some bugs I've heard about with 32-bit vs. 64-bit
>>> offsets in qemu... :) )
>> it works fine with my patches i send to qemu. But right now they're no
>> upstream an nobody of the qemu people answers anymore. So right now i'll
>> keep my patches and be lucky others can't use RBD and fstrim. So maybe
>> inktank should push this a bit more to the qemu people.
>
> If you could send another version with PATCHv3 instead of PATCH in the
> subject, and a description of the changes since the last version between
> the --- and the diffstat, the qemu folks would probably appreciate it.

No idea how to archieve this with git send-email ;-( But still more 
important is also the patch for discards...

> scripts/checkpatch.pl in qemu.git will warn you about style issues like
> the conditionals without braces.

Thank!

0001-rbd-block-driver-fix-race-between-aio-completition-a.patch has no 
obvious style problems and is ready for submission.

Stefan
