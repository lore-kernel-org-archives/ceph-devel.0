From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD v1 image format ...
Date: Thu, 12 Jan 2017 02:56:40 +0900
Message-ID: <CAHX7ARsE08kxOuJhODT4UoQFZ_gU7nigsYgp9ckbXByFszTVog@mail.gmail.com>
References: <CA+aFP1C6Zc0Pry=bqjNBzqBMdd14zRzRMvy9yaQrM+F_SS9xBQ@mail.gmail.com>
	<CAHX7ARuOZ=s5Vr9fHwSo7Sg6AvDq27gBpp7EGvOme8-W3C9DtQ@mail.gmail.com>
	<CAOi1vP_0U6XqVgWz2bLLV=abgrcGNY2zKCEFwq=ULYohcWJF7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAOi1vP_0U6XqVgWz2bLLV=abgrcGNY2zKCEFwq=ULYohcWJF7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Jan 12, 2017 at 2:41 AM, Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Jan 11, 2017 at 6:01 PM, Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> It would be fine to not support v1 image format at all.
>>
>> But it would be probably friendly for users to provide them with more
>> understandable message when they face feature mismatch instead of just
>> displaying:
>>
>>  * rbd: map failed: (6) No such device or address
>>
>> For instance, show the following something in message:
>>
>>  * Execute rbd feature disable <image-name>
>> deep-flatten,fast-diff,object-map,exclusive-lock
>>
>>  or
>>
>>  * Set rbd default features to 3
>
> We already do that in jewel:
>
> $ sudo rbd map a
> rbd: sysfs write failed
> RBD image feature set mismatch. You can disable features unsupported
> by the kernel with "rbd feature disable".
> In some cases useful info is found in syslog - try "dmesg | tail" or so.
> rbd: map failed: (6) No such device or address
>
> Enumerating the features to be disabled is hard because that depends on
> the version of the rbd.ko module and there is no interface for querying
> the feature set.  The man page can definitely be improved though: move
> --image-feature paragraph into its own section, expand the descriptions
> and add kernel version info.  I'll put that on my TODO list...

That would reasonably make sense.

Regards,

>
> Thanks,
>
>                 Ilya
