From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/8] libceph: implement cursor for outgoing data items
Date: Mon, 11 Mar 2013 17:26:26 -0500
Message-ID: <513E5A12.8030806@inktank.com>
References: <513CD9BE.1070505@inktank.com> <513E5988.4000603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:61165 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3CKW03 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 18:26:29 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so3812993obc.20
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 15:26:29 -0700 (PDT)
In-Reply-To: <513E5988.4000603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/11/2013 05:24 PM, Josh Durgin wrote:
> On 03/10/2013 12:06 PM, Alex Elder wrote:
>> This series makes the four distinct data items in a message (the
>> pages array, the pagelist, the bio, and the trail) take a generic
>> form, and then arranges for them all to be handled using a common
>> set of cursor routines that determine what data needs to be sent
>> next for a message.  There is more consolidation of this code
>> coming, but for now I'm leaving this series at 8 patches, which
>> includes the definition of cursor code for the three types of
>> data item.
>>
>>                     -Alex
>>
>> [PATCH 1/8] libceph: define ceph_msg_has_*() data macros
>> [PATCH 2/8] libceph: be explicit about message data representation
>> [PATCH 3/8] libceph: abstract message data
>> [PATCH 4/8] libceph: start defining message data cursor
>> [PATCH 5/8] libceph: prepare for other message data item types
>> [PATCH 6/8] libceph: use data cursor for message pagelist
>> [PATCH 7/8] libceph: implement bio message data item cursor
>> [PATCH 8/8] libceph: implement pages array cursor
> 
> These look good. I assume you're going to remove the single character
> struct members in a later series.

Yes, I did the single characters for brevity, knowing
they'd be going away.

					-Alex
> 
> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

