From: Andreas Calminder <andreas.calminder-HQhCbu9nrx3QT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 13:22:08 +0100
Message-ID: <CAA1GxO0Hprv23L-TOR3eKy9M78y+idU0vBZfAeAPt=6YLa6=Tw@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <CAA1GxO3OwfhXtMx+82k=NO4BXukEyOE9d+Mz-fD4Sr+2psfy1A@mail.gmail.com>
 <CAC-Np1wp1M=qapRO0sCr1HMLpZ2zgLoh-GVv3p01k2DqjxqaOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1wp1M=qapRO0sCr1HMLpZ2zgLoh-GVv3p01k2DqjxqaOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> For the `simple` sub-command there is no prepare/activate, it is just
> a way of taking over management of an already deployed OSD. For *new*
> OSDs, yes, we are implying that we are going only with Logical Volumes
> for data devices. It is a bit more flexible for Journals, block.db,
> and block.wal as those
> can be either logical volumes or GPT partitions (ceph-volume will not
> create these for you).

Ok, so if I understand this correctly, for future one-device-per-osd
setups I would create a volume group per device before handing it over
to ceph-volume, to get the "same" functionality as ceph-disk. I
understand the flexibility aspect of this, my setup will have an extra
step setting up lvm for my osd devices which is fine. Apologies if I
missed the information, but is it possible to get command output as
json, something like "ceph-disk list --format json" since it's quite
helpful while setting up stuff through ansible

Thanks,
Andreas

On 28 November 2017 at 12:47, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, Nov 28, 2017 at 1:56 AM, Andreas Calminder
> <andreas.calminder-HQhCbu9nrx3QT0dZR+AlfA@public.gmane.org> wrote:
>> Hello,
>> Thanks for the heads-up. As someone who's currently maintaining a
>> Jewel cluster and are in the process of setting up a shiny new
>> Luminous cluster and writing Ansible roles in the process to make
>> setup reproducible. I immediately proceeded to look into ceph-volume
>> and I've some questions/concerns, mainly due to my own setup, which is
>> one osd per device, simple.
>>
>> Running ceph-volume in Luminous 12.2.1 suggests there's only the lvm
>> subcommand available and the man-page only covers lvm. The online
>> documentation http://docs.ceph.com/docs/master/ceph-volume/ lists
>> simple however it's lacking some of the ceph-disk commands, like
>> 'prepare' which seems crucial in the 'simple' scenario. Does the
>> ceph-disk deprecation imply that lvm is mandatory for using devices
>> with ceph or is just the documentation and tool features lagging
>> behind, I.E the 'simple' parts will be added well in time for Mimic
>> and during the Luminous lifecycle? Or am I missing something?
>
> In your case, all your existing OSDs will be able to be managed by
> `ceph-volume` once scanned and the information persisted. So anything
> from Jewel should still work. For 12.2.1 you are right, that command
> is not yet available, it will be present in 12.2.2
>
> For the `simple` sub-command there is no prepare/activate, it is just
> a way of taking over management of an already deployed OSD. For *new*
> OSDs, yes, we are implying that we are going only with Logical Volumes
> for data devices. It is a bit more flexible for Journals, block.db,
> and block.wal as those
> can be either logical volumes or GPT partitions (ceph-volume will not
> create these for you).
>
>>
>> Best regards,
>> Andreas
>>
>> On 27 November 2017 at 14:36, Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> For the upcoming Luminous release (12.2.2), ceph-disk will be
>>> officially in 'deprecated' mode (bug fixes only). A large banner with
>>> deprecation information has been added, which will try to raise
>>> awareness.
>>>
>>> We are strongly suggesting using ceph-volume for new (and old) OSD
>>> deployments. The only current exceptions to this are encrypted OSDs
>>> and FreeBSD systems
>>>
>>> Encryption support is planned and will be coming soon to ceph-volume.
>>>
>>> A few items to consider:
>>>
>>> * ceph-disk is expected to be fully removed by the Mimic release
>>> * Existing OSDs are supported by ceph-volume. They can be "taken over" [0]
>>> * ceph-ansible already fully supports ceph-volume and will soon default to it
>>> * ceph-deploy support is planned and should be fully implemented soon
>>>
>>>
>>> [0] http://docs.ceph.com/docs/master/ceph-volume/simple/
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
