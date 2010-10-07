From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 07 Oct 2010 14:51:33 -0500
Message-ID: <4CAE24C5.8030007@codemonkey.ws>
References: <20100802194631.GA4923@chb-desktop>	<alpine.LNX.2.00.1008030033550.2664@linmac>	<20100803201407.GD1475@chb-desktop>	<4CADD567.9010606@codemonkey.ws>	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>	<4CAE13BA.70707@codemonkey.ws> <AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57366 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab0JGTvj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 15:51:39 -0400
In-Reply-To: <AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Christian Brunner <chb@muc.de>, malc <av1474@comtv.ru>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, ceph-devel@vger.kernel.org

On 10/07/2010 01:41 PM, Yehuda Sadeh Weinraub wrote:
> On Thu, Oct 7, 2010 at 11:38 AM, Anthony Liguori<anthony@codemonkey.ws>  wrote:
>    
>> On 10/07/2010 01:08 PM, Yehuda Sadeh Weinraub wrote:
>>      
>>> On Thu, Oct 7, 2010 at 7:12 AM, Anthony Liguori<anthony@codemonkey.ws>
>>>   wrote:
>>>
>>>        
>>>> On 08/03/2010 03:14 PM, Christian Brunner wrote:
>>>>
>>>>          
>>>>> +#include "qemu-common.h"
>>>>> +#include "qemu-error.h"
>>>>> +#include<sys/types.h>
>>>>> +#include<stdbool.h>
>>>>> +
>>>>> +#include<qemu-common.h>
>>>>>
>>>>>
>>>>>            
>>>> This looks to be unnecessary.  Generally, system includes shouldn't be
>>>> required so all of these should go away except rado/librados.h
>>>>
>>>>          
>>> Removed.
>>>
>>>
>>>        
>>>>
>>>>          
>>>>> +
>>>>> +#include "rbd_types.h"
>>>>> +#include "module.h"
>>>>> +#include "block_int.h"
>>>>> +
>>>>> +#include<stdio.h>
>>>>> +#include<stdlib.h>
>>>>> +#include<rados/librados.h>
>>>>> +
>>>>> +#include<signal.h>
>>>>> +
>>>>> +
>>>>> +int eventfd(unsigned int initval, int flags);
>>>>>
>>>>>
>>>>>            
>>>> This is not quite right.  Depending on eventfd is curious but in the very
>>>> least, you need to detect the presence of eventfd in configure and
>>>> provide a
>>>> wrapper that redefines it as necessary.
>>>>
>>>>          
>>> Can fix that, though please see my later remarks.
>>>
>>>        
>>>>> +static int create_tmap_op(uint8_t op, const char *name, char
>>>>> **tmap_desc)
>>>>> +{
>>>>> +    uint32_t len = strlen(name);
>>>>> +    /* total_len = encoding op + name + empty buffer */
>>>>> +    uint32_t total_len = 1 + (sizeof(uint32_t) + len) +
>>>>> sizeof(uint32_t);
>>>>> +    char *desc = NULL;
>>>>>
>>>>>
>>>>>            
>>>> char is the wrong type to use here as it may be signed or unsigned.  That
>>>> can have weird effects with binary data when you're directly manipulating
>>>> it.
>>>>
>>>>          
>>> Well, I can change it to uint8_t, so that it matches the op type, but
>>> that'll require adding some other castings. In any case, you usually
>>> get such a weird behavior when you cast to types of different sizes
>>> and have the sign bit padded which is not the case in here.
>>>
>>>
>>>        
>>>>
>>>>          
>>>>> +
>>>>> +    desc = qemu_malloc(total_len);
>>>>> +
>>>>> +    *tmap_desc = desc;
>>>>> +
>>>>> +    *desc = op;
>>>>> +    desc++;
>>>>> +    memcpy(desc,&len, sizeof(len));
>>>>> +    desc += sizeof(len);
>>>>> +    memcpy(desc, name, len);
>>>>> +    desc += len;
>>>>> +    len = 0;
>>>>> +    memcpy(desc,&len, sizeof(len));
>>>>> +    desc += sizeof(len);
>>>>>
>>>>>
>>>>>            
>>>> Shouldn't endianness be a concern?
>>>>
>>>>          
>>> Right. Fixed that.
>>>
>>>
>>>        
>>>>
>>>>          
>>>>> +
>>>>> +    return desc - *tmap_desc;
>>>>> +}
>>>>> +
>>>>> +static void free_tmap_op(char *tmap_desc)
>>>>> +{
>>>>> +    qemu_free(tmap_desc);
>>>>> +}
>>>>> +
>>>>> +static int rbd_register_image(rados_pool_t pool, const char *name)
>>>>> +{
>>>>> +    char *tmap_desc;
>>>>> +    const char *dir = RBD_DIRECTORY;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = create_tmap_op(CEPH_OSD_TMAP_SET, name,&tmap_desc);
>>>>> +    if (ret<      0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    ret = rados_tmap_update(pool, dir, tmap_desc, ret);
>>>>> +    free_tmap_op(tmap_desc);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>>
>>>>>
>>>>>            
>>>> This ops are all synchronous?  IOW, rados_tmap_update() call blocks until
>>>> the operation is completed?
>>>>
>>>>          
>>> Yeah. And this is only called from the rbd_create() callback.
>>>
>>>
>>>        
>>>>> +            header_snap += strlen(header_snap) + 1;
>>>>> +            if (header_snap>      end)
>>>>> +                error_report("bad header, snapshot list broken");
>>>>>
>>>>>
>>>>>            
>>>> Missing curly braces here.
>>>>
>>>>          
>>> Fixed.
>>>
>>>
>>>        
>>>>> +    if (strncmp(hbuf + 68, RBD_HEADER_VERSION, 8)) {
>>>>> +        error_report("Unknown image version %s", hbuf + 68);
>>>>> +        r = -EMEDIUMTYPE;
>>>>> +        goto failed;
>>>>> +    }
>>>>> +
>>>>> +    RbdHeader1 *header;
>>>>>
>>>>>
>>>>>
>>>>>            
>>>> Don't mix variable definitions with code.
>>>>
>>>>          
>>> Fixed.
>>>
>>>
>>>        
>>>>> +    s->efd = eventfd(0, 0);
>>>>> +    if (s->efd<      0) {
>>>>> +        error_report("error opening eventfd");
>>>>> +        goto failed;
>>>>> +    }
>>>>> +    fcntl(s->efd, F_SETFL, O_NONBLOCK);
>>>>> +    qemu_aio_set_fd_handler(s->efd, rbd_aio_completion_cb, NULL,
>>>>> +        rbd_aio_flush_cb, NULL, s);
>>>>>
>>>>>
>>>>>            
>>>> It looks like you just use the eventfd to signal aio completion
>>>> callbacks.
>>>>   A better way to do this would be to schedule a bottom half.  eventfds
>>>> are
>>>> Linux specific and specific to recent kernels.
>>>>
>>>>          
>>> Digging back why we introduced the eventfd, it was due to some issues
>>> seen with do_savevm() hangs on qemu_aio_flush(). The reason seemed
>>> that we had no fd associated with the block device, which seemed to
>>> not work well with the qemu aio model. If that assumption is wrong,
>>> we'd be happy to change it. In any case, there are other more portable
>>> ways to generate fds, so if it's needed we can do that.
>>>
>>>        
>> There's no fd at all?   How do you get notifications about an asynchronous
>> event completion?
>>
>> Regards,
>>
>> Anthony Liguori
>>
>>      
> (resending to list, sorry)
>
> The fd is hidden deep under in librados. We get callback notifications
> for events completion.
>    

How is that possible?  Are the callbacks delivered in the context of a 
different thread?  If so, don't you need locking?

Regards,

Anthony Liguori

> Thanks,
> Yehuda
>    

