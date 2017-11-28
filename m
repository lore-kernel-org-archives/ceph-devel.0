From: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 10:39:31 -0800
Message-ID: <CAKPXa=Yrwpu-hbpOCSsVfq=GyXHTJ9K8iiLKSJuaYDdBpR+_0A@mail.gmail.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <1821337488.5487.1511856776936@ox.pcextreme.nl>
 <4c4b5589-b1ae-3f8b-e900-af0f2895fbc9@corp.ovh.com>
 <CAC-Np1zsf+uqFi+ZdR7K3=re5ODpJvWFrTX-JU_8DkkyVGOz7A@mail.gmail.com>
 <d548c5a8-c0dc-0737-66f4-e3fc04f900d7@digiware.nl>
 <CAN-Gep+RmSB6gW5GRVsT8T7j60EAzGnfbgeqDjwCNDWocpgp3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAN-Gep+RmSB6gW5GRVsT8T7j60EAzGnfbgeqDjwCNDWocpgp3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 28, 2017 at 9:22 AM, David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Isn't marking something as deprecated meaning that there is a better option
> that we want you to use and you should switch to it sooner than later? I
> don't understand how this is ready to be marked as such if ceph-volume can't
> be switched to for all supported use cases. If ZFS, encryption, FreeBSD, etc
> are all going to be supported under ceph-volume, then how can ceph-disk be
> deprecated before ceph-volume can support them? I can imagine many Ceph
> admins wasting time chasing an erroneous deprecated warning because it came
> out before the new solution was mature enough to replace the existing
> solution.

There is no need to worry about this deprecation, Its mostly for
admins to be prepared
for the changes coming ahead and its mostly for *new* installations
that can plan on using ceph-volume which provides
great flexibility compared to ceph-disk.

a) many dont use ceph-disk or ceph-volume directly, so the tool you
have right now eg: ceph-deploy or ceph-ansible
will still support the ceph-disk, the previous ceph-deploy release is
still available from pypi
  https://pypi.python.org/pypi/ceph-deploy

b) also the current push will help anyone who is using ceph-deploy or
ceph-disk in scripts/chef/etc
   to have time to think about using newer cli based on ceph-volume


> On Tue, Nov 28, 2017 at 9:26 AM Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
>>
>> On 28-11-2017 13:32, Alfredo Deza wrote:
>> >
>> > I understand that this would involve a significant effort to fully
>> > port over and drop ceph-disk entirely, and I don't think that dropping
>> > ceph-disk in Mimic is set in stone (yet).
>>
>> Alfredo,
>>
>> When I expressed my concers about deprecating ceph-disk, I was led to
>> beleive that I had atleast two release cycles to come up with something
>> of a 'ceph-volume zfs ....'
>>
>> Reading this, there is a possibility that it will get dropped IN mimic?
>> Which means that there is less than 1 release cycle to get it working?
>>
>> Thanx,
>> --WjW
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
