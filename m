From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-disk is getting removed from master
Date: Wed, 23 May 2018 13:06:50 -0400
Message-ID: <CAC-Np1ytvVbhaXPE=bmYb3AJE0azM_WomjQRju1PuhKS0jrwLQ@mail.gmail.com>
References: <CAC-Np1yDMEjNsBth_TkzAhbefRZOnXxjVcK2EieMOKXXMWCfpA@mail.gmail.com>
 <a3f0b6e0-4dfc-de8d-756d-b336dd0a0730@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <a3f0b6e0-4dfc-de8d-756d-b336dd0a0730-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, May 23, 2018 at 11:47 AM, Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
> On 23-5-2018 17:12, Alfredo Deza wrote:
>> Now that Mimic is fully branched out from master, ceph-disk is going
>> to be removed from master so that it is no longer available for the N
>> release (pull request to follow)
>
>> Willem, we don't have a way of directly supporting FreeBSD, I've
>> suggested that a plugin would be a good way to consume ceph-volume
>> with whatever FreeBSD needs, alternatively forking ceph-disk could be
>> another option?
>
> Yup, I'm aware of my "trouble"/commitment.
>
> Now that you have riped out most/all of the partitioning stuff there
> should not much that one would need to do in ceph-volume other than
> accept the filestore directories to format the MON/OSD stuff in.

I worry about the way we poke at devices for setups (blkid, lsblk,
/proc/mounts, etc...)

The creation of the OSD (aside from devices) is straightforward

>
> IFF I could find the time to dive into ceph-volume..... :(
> ATM I'm having a hard time keeping up with the changes as it is.
>
> I'd appreciate if you could delay yanking ceph-disk until we are close
> to the nautilus release. At which point feel free to use the axe.

We can't delay this for ~8 months because it will obfuscate what
breakage we will find on our end by ripping it up (teuthology suites,
etc...)

I've already started working on it, and we should be looking at 2 to 3
weeks from today.

>
> --WjW
>
