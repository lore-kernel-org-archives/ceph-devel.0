From: kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dropping trusty
Date: Tue, 5 Dec 2017 00:17:44 +0800
Message-ID: <CAJE9aONh6gtZWNGwYrugRhUnZKWbXv21BRkB4jWqtd6Svs_OKA@mail.gmail.com>
References: <alpine.DEB.2.11.1711301711470.12766@piezo.novalocal>
 <f3f4d84b-2df0-0b7d-65f1-074e4d308348@redhat.com>
 <CAJE9aOP_SXaXsS7DAjvyeNtOD9oK=NTt9j-pbQrCXeD6KwsbVQ@mail.gmail.com>
 <f6c93e1c-ce88-9e44-fc80-07dfc11e3d92@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <f6c93e1c-ce88-9e44-fc80-07dfc11e3d92-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Galloway <dgallowa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Dec 4, 2017 at 11:48 PM, David Galloway <dgallowa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 12/04/2017 01:12 AM, kefu chai wrote:
>> On Fri, Dec 1, 2017 at 1:55 AM, David Galloway <dgallowa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> On 11/30/2017 12:21 PM, Sage Weil wrote:
>>>> We're talking about dropping trusty support for mimic due to the old
>>>> compiler (incomplete C++11), hassle of using an updated toolchain, general
>>>> desire to stop supporting old stuff, and lack of user objections to
>>>> dropping it in the next release.
>>>>
>>>> We would continue to build trusty packages for luminous and older
>>>> releases, just not mimic going forward.
>>>>
>>>> My question is whether we should drop all of the trusty installs on smithi
>>>> and focus testing on xenial and centos.  I haven't seen any trusty related
>>>> failures in half a year.  There were some kernel-related issues 6+ months
>>>> ago that are resolved, and there is a valgrind issue with xenial that is
>>>> making us do valgrind only on centos, but otherwise I don't recall any
>>>> other problems.  I think the likelihood of a trusty-specific regression on
>>>> luminous/jewel is low.  Note that we can still do install and smoke
>>>> testing on VMs to ensure the packages work; we just wouldn't stress test.
>>>>
>>>> Does this seem reasonable?  If so, we could reimage the trusty hosts
>>>> immediately, right?
>>>>
>>>> Am I missing anything?
>>>>
>>>
>>> Someone would need to prune through the qa dir and make sure nothing
>>> relies on trusty for tests.  We've gotten into a bind recently with the
>>
>> David, thanks for point out the direction. i removed the references to trusty
>> and updated related bits in https://github.com/ceph/ceph/pull/19307.
>>
>>> testing of FOG [1] where jobs are stuck in Waiting for a long time
>>> (tying up workers) because jobs are requesting Trusty.  We got close to
>>> having zero Trusty testnodes since the wip-fog branch has been reimaging
>>> baremetal testnodes on every job.
>>>
>>> But other than that, yes, I can reimage the Trusty testnodes.  Once FOG
>>> is merged into teuthology master, we won't have to worry about this
>>> anymore since jobs will automatically reimage machines based on what
>>> distro they require.
>>
>> since https://github.com/ceph/teuthology/pull/1126 is merged, could you help
>> reimage the trusty test nodes?
>>
>
> No need.  Since that's merged, all testnodes are automatically reimaged
> on every job now :).  An e-mail to Sepia user list is forthcoming with
> more details.

awesome, thank you! love this!

>
>>>
>>> [1] https://github.com/ceph/teuthology/compare/wip-fog
>



-- 
Regards
Kefu Chai
