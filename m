From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Does radosgw really need to talk to an MDS?
Date: Mon, 02 Jul 2012 15:22:34 +0200
Message-ID: <4FF1A09A.7010900@widodh.nl>
References: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com> <4FF1898E.7000202@widodh.nl> <CAPUexz9G7Y2dsyU3cTj19tAsVOhGx_fViHYJmnbeEVZJuCheVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58731 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab2GBNWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 09:22:35 -0400
In-Reply-To: <CAPUexz9G7Y2dsyU3cTj19tAsVOhGx_fViHYJmnbeEVZJuCheVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org



On 02-07-12 13:56, Florian Haas wrote:
> On Mon, Jul 2, 2012 at 1:44 PM, Wido den Hollander <wido@widodh.nl> wrote:
>> You are not allowing the RADOS Gateway to do anything on the MDS.
>>
>> There is no 'r',  'w' or 'x' permission which you are allowing. So there is
>> nothing the rgw has access to on the MDS.
>
> Yep, so we might as well leave off "--cap mds 'allow'"?

I think so. You can always give it a try.

The RGW doesn't talk to the MDS anyway, so probably nothing will break.

Wido

>
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

