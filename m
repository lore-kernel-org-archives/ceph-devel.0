From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-disk is getting removed from master
Date: Wed, 23 May 2018 13:03:49 -0400
Message-ID: <CAC-Np1wWQ=xnZfL6BaKreS5YsOa1wTZd6eoTxDSoFSRngHGmjg@mail.gmail.com>
References: <CAC-Np1yDMEjNsBth_TkzAhbefRZOnXxjVcK2EieMOKXXMWCfpA@mail.gmail.com>
 <CAKPXa=ZaQxKwDW721s7+u61j9Dp_qj8dLjXW_qtW5M9jvVC1RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKPXa=ZaQxKwDW721s7+u61j9Dp_qj8dLjXW_qtW5M9jvVC1RQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, May 23, 2018 at 12:12 PM, Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Alfredo,
>
> Do we have the migration docs link from ceph-disk deployment to
> ceph-volume? the current docs as i see lacks scenario migration, maybe
> there is another link ?
> http://docs.ceph.com/docs/master/ceph-volume/simple/#ceph-volume-simple
>
> If it doesn't exist can we document, how a) ceph-disk with filestore
> (with/without) journal can migrate to ceph-volume  and b)
> ceph-disk/bluestore with wal/db on same/different partitions.

There is no "scenario" because ceph-volume scans the existing OSD and
whatever that gives us we work with it:

* filestore with collocated/separate journals
* bluestore in any kind of deployment (with wal, with db, with db and
wal, with main only)

multiply that with *both* ceph-disk's way of encrypting.

In short: we support them all. No special command or flag needed.


>
> Regards
> Vasu
>
>
> On Wed, May 23, 2018 at 8:12 AM, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Now that Mimic is fully branched out from master, ceph-disk is going
>> to be removed from master so that it is no longer available for the N
>> release (pull request to follow)
>>
>> ceph-disk should be considered as "frozen" and deprecated for Mimic,
>> in favor of ceph-volume.
>>
>> This means that if you are relying on ceph-disk *at all*, you should
>> plan on migrating to ceph-volume for Mimic, and should expect breakage
>> if using/testing it in master.
>>
>> Please refer to the guide to migrate away from ceph-disk [0]
>>
>> Willem, we don't have a way of directly supporting FreeBSD, I've
>> suggested that a plugin would be a good way to consume ceph-volume
>> with whatever FreeBSD needs, alternatively forking ceph-disk could be
>> another option?
>>
>>
>> Thanks
>>
>>
>> [0] http://docs.ceph.com/docs/master/ceph-volume/#migrating
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
