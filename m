From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Sat, 01 Dec 2012 21:23:34 +0100
Message-ID: <50BA6746.4010609@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50880 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LAUX1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Dec 2012 15:23:27 -0500
In-Reply-To: <50B484FF.9070500@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,

Am 27.11.2012 10:16, schrieb Stefan Priebe - Profihost AG:
> Am 26.11.2012 21:00, schrieb Dan Mick:
>> It writes zeros; there's no way for it to know how many zeros are
>> coming.  It could make a half-hearted attempt depending on its buffer
>> size and the amount of data the source is willing to buffer.

Yes but why not skip at leas if the WHOLE BUFFER is zero and then use 
the buffer size = stripe size?

Right now a 40GB image which has just 3GB used rest is zeros due to 
using fstrim before doing the export takes a long time to import. We 
could speed this up a lot if we would skip parts with only zeros.

Greets,
Stefab
