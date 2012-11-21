From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd instead of int
Date: Wed, 21 Nov 2012 21:53:32 +0100
Message-ID: <BAA2F264-E952-449D-AA31-AA91603DEC75@profihost.ag>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag> <50AD096E.9080002@weilnetz.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36936 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964798Ab2KUUxz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 15:53:55 -0500
In-Reply-To: <50AD096E.9080002@weilnetz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Weil <sw@weilnetz.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "pve-devel@pve.proxmox.com" <pve-devel@pve.proxmox.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, Stefan Hajnoczi <stefanha@gmail.com>

Not sure about off_t. What is min and max size?

Stefan

Am 21.11.2012 um 18:03 schrieb Stefan Weil <sw@weilnetz.de>:

> Am 20.11.2012 13:44, schrieb Stefan Priebe:
>> rbd / rados tends to return pretty often length of writes
>> or discarded blocks. These values might be bigger than int.
>> 
>> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
>> ---
>>  block/rbd.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/block/rbd.c b/block/rbd.c
>> index f57d0c6..6bf9c2e 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -69,7 +69,7 @@ typedef enum {
>>  typedef struct RBDAIOCB {
>>      BlockDriverAIOCB common;
>>      QEMUBH *bh;
>> -    int ret;
>> +    int64_t ret;
>>      QEMUIOVector *qiov;
>>      char *bounce;
>>      RBDAIOCmd cmd;
>> @@ -87,7 +87,7 @@ typedef struct RADOSCB {
>>      int done;
>>      int64_t size;
>>      char *buf;
>> -    int ret;
>> +    int64_t ret;
>>  } RADOSCB;
>>    #define RBD_FD_READ 0
> 
> 
> Why do you use int64_t instead of off_t?
> If the value is related to file sizes, off_t would be a good choice.
> 
> Stefan W.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
