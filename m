From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: Re: RBD image name constraints
Date: Mon, 11 Apr 2016 10:45:39 +0200
Message-ID: <570B6433.6070608@corp.ovh.com>
References: <5707A2C4.3030102@corp.ovh.com>
 <CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 3.mo175.mail-out.ovh.net ([178.33.255.153]:41141 "EHLO
	3.mo175.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbcDKMWB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 08:22:01 -0400
In-Reply-To: <CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 04/08/2016 06:13 PM, Ilya Dryomov wrote:
> Would you mind sharing some details on what you are doing? If you have 
> a layer of management software on top, it wouldn't be a bad idea to 
> restrict things to a basic A-Za-z0-9+= or so and 96 chars in length. 
I wont be using kernel rbd module so I'll have to assume I'm limited 
with RADOS object names.

I can limit the pool name, but the image name is controlled by the user 
so I'm preparing for the worst here ;)

Regards,
Bartek
