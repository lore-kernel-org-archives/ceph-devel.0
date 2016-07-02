From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cleaning up after in the cmake env?
Date: Sat, 2 Jul 2016 17:38:15 +0200
Message-ID: <876f7d5b-d0cf-8a5e-5a68-0eddffc53fdc@digiware.nl>
References: <1c338fe3-37a7-62f9-439b-dcfbfc873d90@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:60255 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbcGBPib (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 2 Jul 2016 11:38:31 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id BC4DD153416
	for <ceph-devel@vger.kernel.org>; Sat,  2 Jul 2016 17:38:16 +0200 (CEST)
In-Reply-To: <1c338fe3-37a7-62f9-439b-dcfbfc873d90@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2-7-2016 14:22, Willem Jan Withagen wrote:
> Hi,
> 
> How do I cleanup after I've ran a test build?
> Other than thrashing the the full tree and start all over again.

Sort of a dumb question if you know the answer:
	rm -rf build
will cleanup,

Could be a 2 liner in the dev-cmake-guide.

--WjW


