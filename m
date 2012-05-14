From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 3/3] ceph: messenger: change read_partial() to take "end"
 arg
Date: Mon, 14 May 2012 11:28:51 -0500
Message-ID: <4FB132C3.8090306@inktank.com>
References: <4FAC4799.3010903@inktank.com> <4FAC68FF.9020406@inktank.com> <Pine.LNX.4.64.1205121708080.21796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41575 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab2ENQ2w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 12:28:52 -0400
Received: by yenm10 with SMTP id m10so4398131yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 09:28:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205121708080.21796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/12/2012 07:11 PM, Sage Weil wrote:
> This looks correct, but seems like a more confusing calling convention
> to me.  Before this patch it's basically a (start, len) logical
> range in the input stream.. after it's (end, len).  It also seems to be
> more code?
>
> sage
>
> On Thu, 10 May 2012, Alex Elder wrote:
>
>> Make the second argument to read_partial() be the ending input byte
>> position rather than the beginning offset it now represents.  This
>> amounts to moving the addition "to + size" into the caller.
>>
>> Signed-off-by: Alex Elder<elder@inktank.com>
>> ---

Note that this patch also left the local variable "to" in
read_partial_message() unused.  I'll delete its definition
before I commit.

Thanks for the review.

					-Alex

. . .
>> @@ -1755,8 +1771,9 @@ static int read_partial_message(struct ceph_connection
>> *con)
>>   	}
>>
>>   	/* footer */
>> -	to = sizeof (m->hdr);
>> -	ret = read_partial(con, to, sizeof (m->footer),&m->footer);
>> +	size = sizeof (m->footer);
>> +	end += size;
>> +	ret = read_partial(con, end, size,&m->footer);
>>   	if (ret<= 0)
>>   		return ret;
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>

