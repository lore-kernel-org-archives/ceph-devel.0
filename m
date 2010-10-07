From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [PATCH] ceph/rbd block driver for qemu-kvm (v4)
Date: Thu, 07 Oct 2010 16:55:09 -0500
Message-ID: <4CAE41BD.2070508@codemonkey.ws>
References: <20100802194631.GA4923@chb-desktop>	<alpine.LNX.2.00.1008030033550.2664@linmac>	<20100803201407.GD1475@chb-desktop>	<4CADD567.9010606@codemonkey.ws>	<AANLkTikuNq1ApT+2ML6s6NXXpTZaedgJDG1xq_=oBQPK@mail.gmail.com>	<4CAE13BA.70707@codemonkey.ws>	<AANLkTim2qfA+MncyF9Cx1oGYEzgW2TugG9sFTLP8T=J-@mail.gmail.com>	<4CAE24C5.8030007@codemonkey.ws>	<AANLkTimW98qPTYZ=Bct7k7XqaOXswC51QdQOW6fLsWkQ@mail.gmail.com>	<4CAE35C5.2010809@codemonkey.ws> <AANLkTinzdiJZFxacD1BDCPWt44ChokNaNVU6_E=GtcTD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTinzdiJZFxacD1BDCPWt44ChokNaNVU6_E=GtcTD@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>
List-Id: ceph-devel.vger.kernel.org

On 10/07/2010 04:49 PM, Yehuda Sadeh Weinraub wrote:
> On Thu, Oct 7, 2010 at 2:04 PM, Anthony Liguori<anthony@codemonkey.ws>  wrote:
>    
>> On 10/07/2010 03:47 PM, Yehuda Sadeh Weinraub wrote:
>>      
>>>> How is that possible?  Are the callbacks delivered in the context of a
>>>> different thread?  If so, don't you need locking?
>>>>
>>>>          
>>> Not sure I'm completely following you. The callbacks are delivered in
>>> the context of a different thread, but won't run concurrently.
>>>        
>> Concurrently to what?  How do you prevent them from running concurrently
>> with qemu?
>>      
> There are two types of callbacks. The first is for rados aio
> completions, and the second one is the one added later for the fd glue
> layer.
>    

This is a bad architecture for something like qemu.  You could create a 
pipe and use the pipe to signal to qemu.  Same principle as eventfd.  
Ideally, you would do this in the library itself.

Regards,

Anthony Liguori

> The first callback, called by librados whenever aio completes, runs in
> the context of a single librados thread:
>
> +static void rbd_finish_aiocb(rados_completion_t c, RADOSCB *rcb)
> +{
> +    RBDAIOCB *acb = rcb->acb;
> rcb is per a single aio. Was created  before and will be destroyed
> here, whereas acb is shared between a few aios, however, it was
> generated before the first aio was created.
>
> +    int64_t r;
> +    uint64_t buf = 1;
> +    int i;
> +
> +    acb->aiocnt--;
>
> acb->aiocnt has been set before initiating all the aios, so it's ok to
> touch it now. Same goes to all acb fields.
>
> +    r = rados_aio_get_return_value(c);
> +    rados_aio_release(c);
> +    if (acb->write) {
> +        if (r<  0) {
> +            acb->ret = r;
> +            acb->error = 1;
> +        } else if (!acb->error) {
> +            acb->ret += rcb->segsize;
> +        }
> +    } else {
> +        if (r == -ENOENT) {
> +            memset(rcb->buf, 0, rcb->segsize);
> +            if (!acb->error) {
> +                acb->ret += rcb->segsize;
> +            }
> +        } else if (r<  0) {
> +            acb->ret = r;
> +            acb->error = 1;
> +        } else if (r<  rcb->segsize) {
> +            memset(rcb->buf + r, 0, rcb->segsize - r);
> +            if (!acb->error) {
> +                acb->ret += rcb->segsize;
> +            }
> +        } else if (!acb->error) {
> +            acb->ret += r;
> +        }
> +    }
> +    if (write(acb->s->efd,&buf, sizeof(buf))<  0)
> This will wake up the io_read()
>
> +        error_report("failed writing to acb->s->efd\n");
> +    qemu_free(rcb);
> +    i = 0;
> +    if (!acb->aiocnt&&  acb->bh) {
> +        qemu_bh_schedule(acb->bh);
> This is the only qemu related call in here, seems safe to call it.
>
> +    }
> +}
>
> The scheduled bh function will be called only after all aios that
> relate to this specific aio set are done, so the following seems ok,
> as there's no more acb references.
> +static void rbd_aio_bh_cb(void *opaque)
> +{
> +    RBDAIOCB *acb = opaque;
> +    uint64_t buf = 1;
> +
> +    if (!acb->write) {
> +        qemu_iovec_from_buffer(acb->qiov, acb->bounce, acb->qiov->size);
> +    }
> +    qemu_vfree(acb->bounce);
> +    acb->common.cb(acb->common.opaque, (acb->ret>  0 ? 0 : acb->ret));
> +    qemu_bh_delete(acb->bh);
> +    acb->bh = NULL;
> +
> +    if (write(acb->s->efd,&buf, sizeof(buf))<  0)
> +        error_report("failed writing to acb->s->efd\n");
> +    qemu_aio_release(acb);
> +}
>
> Now, the second ones are the io_read(), in which we have our glue fd.
> We send uint64 per each completed io
>
> +static void rbd_aio_completion_cb(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    uint64_t val;
> +    ssize_t ret;
> +
> +    do {
> +        if ((ret = read(s->efd,&val, sizeof(val)))>  0) {
> +            s->qemu_aio_count -= val;
> There is an issue here with s->qemu_aio_count which needs to be
> protected by a mutex. Other than that, it just reads from s->efd.
>
> +       }
> +    } while (ret<  0&&  errno == EINTR);
> +
> +    return;
> +}
> +
> +static int rbd_aio_flush_cb(void *opaque)
> +{
> +    BDRVRBDState *s = opaque;
> +
> +    return (s->qemu_aio_count>  0);
> Same here as with the previous one, needs a mutex around s->qemu_aio_count.
>
> +}
>
>    
>> If you saw lock ups, I bet that's what it was from.
>>
>>      
> As I explained before, before introducing the fd glue layer, the lack
> of fd associated with our block device caused that there was no way
> for qemu to check whether all aios were flushed or not, which didn't
> work well when doing migration/savevm.
>
> Thanks,
> Yehuda
>    

