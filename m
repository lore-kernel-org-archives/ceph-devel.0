From: Wido den Hollander <wido@42on.com>
Subject: Re: libvirt: Removing RBD volumes with snapshots, auto purge or not?
Date: Tue, 20 Aug 2013 21:01:01 +0200
Message-ID: <5213BCED.7010400@42on.com>
References: <52138CEF.8010109@42on.com> <CABYiri-Z_9sW155BpOzHsSOAfaBmdzW=1DetXVD3-Mz5ESbPdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:44930 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab3HTTBE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Aug 2013 15:01:04 -0400
In-Reply-To: <CABYiri-Z_9sW155BpOzHsSOAfaBmdzW=1DetXVD3-Mz5ESbPdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/20/2013 05:43 PM, Andrey Korolyov wrote:
> On Tue, Aug 20, 2013 at 7:36 PM, Wido den Hollander <wido@42on.com> wrote:
>> Hi,
>>
>> The current [0] libvirt storage pool code simply calls "rbd_remove" without
>> anything else.
>>
>> As far as I know rbd_remove will fail if the image still has snapshots, you
>> have to remove those snapshots first before you can remove the image.
>>
>> The problem is that libvirt's storage pools do not support listing
>> snapshots, so we can't integrate that.
>>
>> Libvirt however has a flag you can pass down to tell you want the device to
>> be zeroed.
>>
>> The normal procedure is that the device is filled with zeros before actually
>> removing it.
>>
>> I was thinking about "abusing" this flag to use it as a snap purge for RBD.
>>
>> So a regular volume removal will call only rbd_remove, but when the flag
>> VIR_STORAGE_VOL_DELETE_ZEROED is passed it will purge all snapshots prior to
>> calling rbd_remove.
>>
>> Another way would be to always purge snapshots, but I'm afraid that could
>> make somebody very unhappy at some point.
>>
>> Currently "virsh" doesn't support flags, but that could be fixed in a
>> different patch.
>>
>> Does my idea sound sane?
>>
>> [0]:
>> http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=e3340f63f412c22d025f615beb7cfed25f00107b;hb=master#l407
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>
> Hi Wido,
>
>
> You had mentioned not so long ago the same idea as I had about a year
> and half ago about placing memory dumps along with the regular
> snapshot in Ceph using libvirt mechanisms. That sounds pretty nice
> since we`ll have something other than qcow2 with same snapshot
> functionality but your current proposal does not extend to this.

Correct, since this is about the storage pool support, that is something 
completely different.

> Placing custom side hook seems much more expandable than putting snap
> purge into specific flag.
>

My proposal is a bit selfish, since I'm running into this with 
CloudStack. CloudStack now has a work-around for RBD since images could 
still have snapshots where other storage types are handled by libvirt.

I want to have it all handled by libvirt.

Wido

>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
