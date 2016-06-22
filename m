From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Not matching event states in ./msg/async/AsyncConnection.cc
Date: Thu, 23 Jun 2016 00:16:56 +0200
Message-ID: <1fef436f-c122-e66d-59c9-257bc2360722@digiware.nl>
References: <0a8a87d5-777c-7e78-0400-cf1978217928@digiware.nl>
 <a95dcbdc-2447-076a-516d-bb717d58ca0c@digiware.nl>
 <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static.ip-176-74-240-009.signet.nl ([176.74.240.9]:22167 "EHLO
	smtp.digiware.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcFVWRb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 18:17:31 -0400
In-Reply-To: <CACJqLyYq5vBMokPwdG_D=4qPAOp0tDyMe07gzOZWS6K-61J0nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 22-6-2016 16:36, Haomai Wang wrote:
> Oh, sorry. I still realize you are testing on kqueue event backend.
> 
> I submit a pr to fix this. plz help to verify whether it works for you
> since I don't have bsd handy...
> 
> https://github.com/ceph/ceph/pull/9869

I think add_event needs about the same treatment.
Trying, Testing ATM....

--WjW

