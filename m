From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: abstract setting message data info
Date: Tue, 26 Feb 2013 10:39:04 -0800
Message-ID: <512D0148.70200@inktank.com>
References: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:36360 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759675Ab3BZSj2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 13:39:28 -0500
Received: by mail-da0-f52.google.com with SMTP id x33so1120591dad.11
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 10:39:27 -0800 (PST)
In-Reply-To: <512BF683.5050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/25/2013 03:40 PM, Alex Elder wrote:
> This series makes the fields related to the data portion of
> a ceph message not get manipulated by code outside the ceph
> messenger.  It implements some interface functions that can
> be used to assign data-related fields.  Doing this will allow
> the way message data is managed to be changed independent
> of the users of the messenger module.
>
> 					-Alex
>
> [PATCH 1/4] libceph: distinguish page array and pagelist count
> [PATCH 2/4] libceph: set page alignment in start_request()
> [PATCH 3/4] libceph: isolate message page field manipulation
> [PATCH 4/4] libceph: isolate other message data fields

These all look good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

