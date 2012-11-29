From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Thu, 29 Nov 2012 11:26:27 +0100
Message-ID: <50B73853.5050000@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag> <50B543A9.1080901@inktank.com> <50B5C6C9.1020303@profihost.ag> <50B65D4D.7020804@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45983 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab2K2K0f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 05:26:35 -0500
In-Reply-To: <50B65D4D.7020804@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Josh,

Am 28.11.2012 19:51, schrieb Josh Durgin:

>> No idea how to archieve this with git send-email ;-( But still more
>> important is also the patch for discards...
>
> Use git format-patch, edit the patch file (it includes the basic
> headers already), then send it with git send-email.

done / fixed

> Your return value type change was already merged into master of
> qemu.git as 08448d5195aeff49bf25fb62b4a6218f079f5284.

Oh thanks i didn't get a reply that it is applied.

Stefan
