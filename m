From: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: cephfs snapshot format upgrade
Date: Wed, 11 Apr 2018 16:11:04 -0700
Message-ID: <CAJ4mKGYmp+qW8nT==Tshncbe4Ne9hQ=R0eegM8CmTUWSdmWYPg@mail.gmail.com>
References: <CAAM7YAnaiG6sTcQ=O7Sg36kq9u=APfOffBY4aY4OjWCGtfTNGQ@mail.gmail.com>
 <CALe9h7fDviOKe6x4=yOP_DM1L=sNXNrWdM3OaavMS+wLdEQHGQ@mail.gmail.com>
 <CAJ4mKGaKcU6uSLhrT1xRUdmPo7ux7EyX1h6G1N95mWqokudkyQ@mail.gmail.com>
 <CAAM7YAmsz-Pkvdub5z4e_YH5+++yg+F_e1N6LSOzf63OR92Lzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAAM7YAmsz-Pkvdub5z4e_YH5+++yg+F_e1N6LSOzf63OR92Lzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Apr 10, 2018 at 8:50 PM, Yan, Zheng <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Apr 11, 2018 at 3:34 AM, Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> On Tue, Apr 10, 2018 at 5:54 AM, John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> On Tue, Apr 10, 2018 at 1:44 PM, Yan, Zheng <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hello
>>>>
>>>> To simplify snapshot handling in multiple active mds setup, we changed
>>>> format of snaprealm in mimic dev.
>>>> https://github.com/ceph/ceph/pull/16779.
>>>>
>>>> The new version mds can handle old format snaprealm in single active
>>>> setup. It also can convert old format snaprealm to the new format when
>>>> snaprealm is modified. The problem is that new version mds can not
>>>> properly handle old format snaprealm in multiple active setup. It may
>>>> crash when it encounter old format snaprealm. For existing filesystem
>>>> with snapshots, upgrading mds to mimic seems to be no problem at first
>>>> glance. But if user later enables multiple active mds,  mds may
>>>> crashes continuously. No easy way to switch back to single acitve mds.
>>>>
>>>> I don't have clear idea how to handle this situation. I can think of a
>>>> few options.
>>>>
>>>> 1. Forbid multiple active before all old snapshots are deleted or
>>>> before all snaprealms are converted to new format. Format conversion
>>>> requires traversing while whole filesystem tree.  Not easy to
>>>> implement.
>>>
>>> This has been a general problem with metadata format changes: we can
>>> never know if all the metadata in a filesystem has been brought up to
>>> a particular version.  Scrubbing (where scrub does the updates) should
>>> be the answer, but we don't have the mechanism for recording/ensuring
>>> the scrub has really happened.
>>>
>>> Maybe we need the MDS to be able to report a complete whole-filesystem
>>> scrub to the monitor, and record a field like
>>> "latest_scrubbed_version" in FSMap, so that we can be sure that all
>>> the filesystem metadata has been brought up to a certain version
>>> before enabling certain features?  So we'd then have a
>>> "latest_scrubbed_version >= mimic" test before enabling multiple
>>> active daemons.
>>
>> Don't we have a (recursive!) last_scrub_[stamp|version] on all
>> directories? There's not (yet) a mechanism for associating that with
>> specific data versions like you describe here, but for a one-time
>> upgrade with unsupported features I don't think we need anything too
>> sophisticated.
>> -Greg
>>
> No, we don't.  Besides, normal recursive stats (record last update) does not
> work for this case. We need a recursive stat that tracks the oldest
> update on all
> directories..

Well, inode_t has a last_scrub_version and last_scrub_stamp member.
They're part of encoding version 13. My recollection is that a scrub
on a directory is only considered complete when all of its descendants
have scrubbed, but maybe I'm misremembering and we'll happily do one
at a time.

I think I saw elsewhere that dealing with the upgrades is now
in-progress though so I presume some other solution came to hand.
-Greg
