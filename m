From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 08:31:41 -0500
Message-ID: <5331853D.40408@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>	 <53316D18.7040103@ieee.org>	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>	 <53317BC2.9010700@ieee.org>	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com> <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36428 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaCYNbX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 09:31:23 -0400
Received: by mail-qc0-f174.google.com with SMTP id c9so503434qcz.33
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 06:31:22 -0700 (PDT)
In-Reply-To: <533184AF.9050101@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

...
>> So, a (partial) fix can be this patch ?
>>
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -2123,6 +2123,7 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>>         rbd_assert(obj_request_img_data_test(obj_request));
>>         img_request = obj_request->img_request;
>>  
>> +       spin_lock_irq(&img_request->completion_lock);
>>         dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
>>         rbd_assert(img_request != NULL);
>>         rbd_assert(img_request->obj_request_count > 0);
>> @@ -2130,7 +2131,6 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
>>         rbd_assert(which < img_request->obj_request_count);
>>         rbd_assert(which >= img_request->next_completion);
>>  
>> -       spin_lock_irq(&img_request->completion_lock);
>>         if (which != img_request->next_completion)
>>                 goto out;
> 
> 
> Yes, roughly.  I'd do the following instead.  It would be great
> to learn whether it eliminates the one form of assertion failure
> you were seeing.
> 
> 					-Alex
>


Strike that, my last patch was dead wrong.  Sorry.  Try this:

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2128,11 +2128,11 @@ static void rbd_img_obj_callback(struct
 	rbd_assert(img_request->obj_request_count > 0);
 	rbd_assert(which != BAD_WHICH);
 	rbd_assert(which < img_request->obj_request_count);
-	rbd_assert(which >= img_request->next_completion);

 	spin_lock_irq(&img_request->completion_lock);
-	if (which != img_request->next_completion)
+	if (which > img_request->next_completion)
 		goto out;
+	rbd_assert(which == img_request->next_completion);

 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);


