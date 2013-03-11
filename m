From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/8] libceph: implement cursor for outgoing data items
Date: Mon, 11 Mar 2013 15:24:08 -0700
Message-ID: <513E5988.4000603@inktank.com>
References: <513CD9BE.1070505@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33254 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab3CKWYu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 18:24:50 -0400
Received: by mail-pb0-f50.google.com with SMTP id up1so4255797pbc.37
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 15:24:49 -0700 (PDT)
In-Reply-To: <513CD9BE.1070505@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/10/2013 12:06 PM, Alex Elder wrote:
> This series makes the four distinct data items in a message (the
> pages array, the pagelist, the bio, and the trail) take a generic
> form, and then arranges for them all to be handled using a common
> set of cursor routines that determine what data needs to be sent
> next for a message.  There is more consolidation of this code
> coming, but for now I'm leaving this series at 8 patches, which
> includes the definition of cursor code for the three types of
> data item.
>
> 					-Alex
>
> [PATCH 1/8] libceph: define ceph_msg_has_*() data macros
> [PATCH 2/8] libceph: be explicit about message data representation
> [PATCH 3/8] libceph: abstract message data
> [PATCH 4/8] libceph: start defining message data cursor
> [PATCH 5/8] libceph: prepare for other message data item types
> [PATCH 6/8] libceph: use data cursor for message pagelist
> [PATCH 7/8] libceph: implement bio message data item cursor
> [PATCH 8/8] libceph: implement pages array cursor

These look good. I assume you're going to remove the single character
struct members in a later series.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
