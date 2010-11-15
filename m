From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] ceph/rbd block driver for qemu-kvm (v7)
Date: Mon, 15 Nov 2010 09:10:08 -0800
Message-ID: <AANLkTi=w3XNhBeWE4E9b08gijYdR81mWZ4M9fubm8kJ+@mail.gmail.com>
References: <20101015195424.GA4094@dell.home>
	<AANLkTikE3UX8AxmfiwwVgR7_NxL=p=1CCD+6wwomwBkQ@mail.gmail.com>
	<AANLkTik0=3tDxu+PMA-JzGwLaCYRGQfRugm36h3L=xvn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTik0=3tDxu+PMA-JzGwLaCYRGQfRugm36h3L=xvn@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <c.m.brunner@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, kwolf@redhat.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Nov 15, 2010 at 9:04 AM, Christian Brunner
<c.m.brunner@gmail.com> wrote:
> Hi Stefan,
>
> thanks for your feedback. Yehuda and Sage have already committed some
> pathes to our git repository.
>
> What I'm not sure about is the rados_(de)initialization for multiple
> rbd images. I suspect that _deinitialize should only be called for th=
e
> last rbd image.
>
> Yehuda and Sage know librados a lot better than me. I pretty sure,
> that they will give some feedback about this remaining issue. After
> that we will send an updated patch.
>
> Regards,
> Christian
>
> 2010/11/11 Stefan Hajnoczi <stefanha@gmail.com>:
>> On Fri, Oct 15, 2010 at 8:54 PM, Christian Brunner <chb@muc.de> wrot=
e:
>>> [...]
>>> +
>>> + =A0 =A0if ((r =3D rados_initialize(0, NULL)) < 0) {
>>> + =A0 =A0 =A0 =A0error_report("error initializing");
>>> + =A0 =A0 =A0 =A0return r;
>>> + =A0 =A0}
>>
>> Does rados_initialize() work when called multiple times? =A0This wou=
ld happen if
>> the VM has several rbd devices attached.
>>
>> [...]
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

The rados (de)initialization is refcounted and it is safe to call it
multiple times.
