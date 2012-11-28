From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd STDIN import does not work / wip-rbd-export-stdout
Date: Wed, 28 Nov 2012 15:53:52 +0100
Message-ID: <50B62580.2030301@profihost.ag>
References: <50B36C9F.80107@profihost.ag> <50B36ED1.1020108@filoo.de> <50B37027.5000701@profihost.ag> <CAHybQB3qhoAXwhyDz16-D6EOidcPYg4p=hRwc7ag_tAq_Z_edA@mail.gmail.com> <2EC6C33E-4909-4AE5-B8C0-5D7A5856EA57@profihost.ag> <50B3CA6F.6000000@inktank.com> <50B484FF.9070500@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45331 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab2K1Ox7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 09:53:59 -0500
In-Reply-To: <50B484FF.9070500@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Dan,

thanks for your update / new import-export branch.

The import seems to work now. What i'm wondering is that it is really slow.

I see around 10% CPU Usage on importing host (host where rbd import is 
started) and just 4MB every 2s raising Data on ceph. This means 40GB 
took around 5-6 hours.

Night this be due to he size update? 4MB every 2s looks like the stripe 
size.

Greets,
Stefan
