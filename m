From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 07/14] libceph: unregister only registered linger requests
Date: Mon, 30 Jun 2014 18:21:58 +0400
Message-ID: <CALFYKtDuxxaVdXtNMWYJHq=fs7KPcXVSQ2TKF4RwnL4DZcnDnQ@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
	<53B16B42.80902@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:43146 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbaF3OV7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 10:21:59 -0400
Received: by mail-qg0-f47.google.com with SMTP id q108so2034592qgd.34
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 07:21:58 -0700 (PDT)
In-Reply-To: <53B16B42.80902@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 30, 2014 at 5:50 PM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> Linger requests that have not yet been registered should not be
>> unregistered by __unregister_linger_request().  This messes up ref
>> count and leads to use-after-free.
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  net/ceph/osd_client.c |   15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index a9b7ea7bfdc6..12ec553a7e76 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1248,7 +1248,9 @@ static void __cancel_request(struct ceph_osd_request *req)
>>  static void __register_linger_request(struct ceph_osd_client *osdc,
>>                                   struct ceph_osd_request *req)
>>  {
>> -     dout("__register_linger_request %p\n", req);
>> +     dout("%s %p tid %llu\n", __func__, req, req->r_tid);
>> +     WARN_ON(!req->r_linger);
>> +
>>       ceph_osdc_get_request(req);
>>       list_add_tail(&req->r_linger_item, &osdc->req_linger);
>>       if (req->r_osd)
>> @@ -1259,8 +1261,17 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
>>  static void __unregister_linger_request(struct ceph_osd_client *osdc,
>>                                       struct ceph_osd_request *req)
>>  {
>> -     dout("__unregister_linger_request %p\n", req);
>> +     WARN_ON(!req->r_linger);
>
>
> I just noticed something.  ceph_osdc_unregister_linger_request()
> clears req->r_linger before calling __unregister_linger_request(),
> which means this warning must be tripping a lot...
>
> Just delete that assignment in ceph_osdc_unregister_linger_request()
> as part of this commit.

ceph_osdc_unregister_linger_request() is removed entirely later in the
series.

Thanks,

                Ilya
