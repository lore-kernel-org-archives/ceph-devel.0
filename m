From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: Re: rgw: bug#17111 ERROR: got unexpected error when trying to read
 object: -2
Date: Wed, 14 Sep 2016 18:26:36 +0800
Message-ID: <57D925DC.1060007@xtaotech.com>
References: <57D8C520.9020102@xtaotech.com>
 <CADRKj5SZe1rQtqn7w3+Yw=ctdU=kkMBwGNUe_b_2rHs6dMesLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:39187 "EHLO
        mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756012AbcINK0k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2016 06:26:40 -0400
In-Reply-To: <CADRKj5SZe1rQtqn7w3+Yw=ctdU=kkMBwGNUe_b_2rHs6dMesLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Javen Wu <javen.wu@xtaotech.com>



On 09/14/2016 02:15 PM, Yehuda Sadeh-Weinraub wrote:
> On Tue, Sep 13, 2016 at 8:33 PM, Yang Joseph <joseph.yang@xtaotech.com> wrote:
>> Hello Oritwas,
>>
>> I am aware of that you are responsible for the issue 17111
>> (http://tracker.ceph.com/issues/17111).
>> Actually, I proposed two fixes already. Could you please take a look at
>> them?
>>
>> 1.
>> https://github.com/ceph/ceph/pull/10820/commits/2e95e2c824c6cc829c39180b0f6809ff312e5892
>>
>> In this proposal, I added two items into manifest :
>>
>> src_instance
>> copied_object
>>
>> "copied_object" is used to indicate whether this object is generated through
>> COPY operation.
>> If so, we must overwrite "instance" with "src_instance" in the GET
>> operation.
>> If not, go as before.
>>
>> We don't need extra tools to fix the old object's manifest that created
>> before this patch, because
>> copied_object's default value is false.
>>
>> 2.
>> https://github.com/ceph/ceph/pull/10820/commits/5104f852d255cfc140be33885f696b7f93a6cfad
>>
>> This is an optimized version.  Only src_instance is added to manifest.
>> In order to distinguish object generated through COPY operation from object
>> generated through
>> PUT operation, I make the none copied object's src_instance equal to its
>> instance value.
>> So if src_instance not equal to its instance, this is a copied object.
>>
>> However, this proposal need an extra tool to migrate old objects to new
>> version RGW with this patch.
> Migration is really a no go. The way to go would be by having the
> decode function smart enough to know whether it's prior to the change
> or after the change and set the field accordingly. That been said, I
> think that instead of calling the field 'src_instance', call it
> 'tail_instance', and always use it when accessing the tail. When
> copying the object, copy that field. When creating a versioned object,
> that field should be equal to the instance field. When decoding an old
> object, it should be set appropriately. Does that make sense?
Good idea! I already commit a new modification according to your
suggestion. Please help review it 
(https://github.com/ceph/ceph/pull/10820/files).

thx,

Yang Honggang
>
> Yehuda
>
>> Your comments are highly appreciated!
>>
>> thx,
>>
>> Yang Honggang
>>

