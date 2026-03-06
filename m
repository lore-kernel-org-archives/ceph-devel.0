Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1933CE92
	for <ceph-devel@vger.kernel.org>; Fri,  6 Mar 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788464; cv=none; b=L1sIjW7By4b6kqGMKmPR5vnZ+3jIrDWwvBK6PKZxQEkg9byklRg8FEg2DKO+9joC+FhoaufjW9F/H8GZQPxf9R+pDfk9RnnNDr4rRNIOC9VvweopQBu5jLqKPuCQ0jbeNNCWT80gvmOMFnh5AiJYr3A47ZmEZfT21x4QDo63DNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788464; c=relaxed/simple;
	bh=sbhzQv7MpEeLRqSyBB7McdZUDK+R7lBz9aIyg+8aGSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7IF3x/47mp8U9639UDAaUGB6gcrB77t1bIEEX42ppqToQyjGW3Cq/xanQDtQPHVdaN6dyhbefBK4e37SXiBBep9hZws9/w+LmXltmwqQi8onF/kGfIIx2Hj2ZmVZ8RbzK7R2rXolxq14yqZg/GrwWtfL5AUFTl3SE482rhdVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=KIvwndc7; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="KIvwndc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1772788459; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=sbhzQv7MpEeLRqSyBB7McdZUDK+R7lBz9aIyg+8aGSk=;
 b=KIvwndc7Rh1v49f6eh9ro9h3TPjwQcQ+yvBmsDoACkWxFUuLeEpLtWIgXxcR/WTbn0J/S
 WCn0ZnNEbJguxpY029l36oCRDlM33V07vpgqRHGwZC1wUnPWvGtL2OAF1M4gXt398uKa0cX
 GcSkfC44hH3jIiLRstFAv3E9DbAjitb4qud/0m/2bpXiNihTVJzFrQ0TPkm1W/IkB5YO8fY
 6A4C72MAgIXLBOIjwZQTfiGcFh9F7UUiiGApu/t//enxSMkYwdjxzDCZ2yveCDqJVa8efV2
 jb4C8vEbbvfCVNigkQYd9/dthVjserjEONHGX69+K3VKHltCB6a6k0vDgUlg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 25CAC5FD56;
	Fri,  6 Mar 2026 10:14:18 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 800775FB23;
	Fri,  6 Mar 2026 10:14:18 +0100 (CET)
Message-ID: <1b946af9-8c9f-49e4-9f36-efacaf2bcbde@tu-ilmenau.de>
Date: Fri, 6 Mar 2026 10:14:18 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
 <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.03.26 8:33 PM, Viacheslav Dubeyko wrote:
> On Thu, 2026-03-05 at 17:40 +0100, Raphael Zimmer wrote:
>> This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
>> that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
>> ceph_handle_auth_reply(), the value of the payload_len field of such a
>> message is stored in a variable of type int. A value greater than
>> INT_MAX leads to an integer overflow and is interpreted as a negative
>> value. This leads to decrementing the pointer address by this value and
>> subsequently accessing it because ceph_decode_need() only checks that
>> the memory access does not exceed the end address of the allocation.
>>
> 
> Do you mean that payload_len could be bigger than INT_MAX? Is it possible
> scenario to have so big payload size in one message?
> 
> Maybe, the problem is more serious than simple changing of int on u32? It sounds
> like we are hiding a real issue by this fix.
> 
> Thanks,
> Slava.
> 

Hi Slava,
actually, I don't think that a correctly functioning monitor will ever
send an auth_reply message with a payload larger than 2GB. This patch
shall prevent a (maliciously) corrupted message with a huge value in the
payload_len field from causing a memory access to an out-of-bounds address.

Best regards,
Raphael

