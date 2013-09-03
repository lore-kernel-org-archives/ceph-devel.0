From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v2 3/3] rbd: make rbd_obj_notify_ack() synchronous
Date: Tue, 03 Sep 2013 08:07:17 -0500
Message-ID: <5225DF05.70709@linaro.org>
References: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com> <1377824228-14632-3-git-send-email-josh.durgin@inktank.com> <5225DE95.4050700@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35570 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3ICNHM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 09:07:12 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so9801618iea.23
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 06:07:11 -0700 (PDT)
In-Reply-To: <5225DE95.4050700@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/03/2013 08:05 AM, Alex Elder wrote:
> There's another problem though.  This function used a clever trick of
> assigning rbd_obj_request_put() as the object request's callback
> function.  This allowed the request to just be sent and cleaned up
> whenever it completed.

Oh, sorry, I neglected to notice you already deleted this.
You still need to call it after waiting though, so make
the call to rbd_obj_request_put() unconditional at the end.

					-Alex
