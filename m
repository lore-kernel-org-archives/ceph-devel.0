From: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Thu, 23 Aug 2018 12:15:15 +0200
Message-ID: <cddb7650-4d62-cb25-eab8-3a57f80a080f@digiware.nl>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: nl
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 22/08/2018 19:42, Ernesto Puerta wrote:
> Thanks for your feedback, Willem!
> 
>> The old dashboard does not need any package fetch while
>> building/installing. Something that is not very handy when building
>> FreeBSD packages. And I haven't gotten around to determining how to > get around that.
> 
> I thought that https://github.com/ceph/ceph/pull/22562 fixed make-dist
> issues on FreeBSD. Is that not working yet? Let us know if that's the
> case!

Eh, yes and no....
The PR allows me to build dashboard in tree. All the guarding with 
nodeenv and such are not there. So that is already less clean than it 
should be, but it works for testing.

Now building a FreeBSD package is a totally different cookie.
That does not work with the way it is now designed.
FreeBSD package building does not allow data to be fetch half way thru 
the build process!!! So calling something like npm during building is taboo.

There is a fetch stage, where al the sources and submodules are fetched.
And I have 2 make targets: pre_fetch and post_fetch where I can get 
extra sources that are required.
Problem is also that the sources are only unpacked AFTER post_fetch, so
even running a part of the Cmake code in post_fetch does not work, 
because the tree is not there.

And it hard to track what npm is al installing, because it seems it is 
pulling in a complete forrest of new dependancies.

So my way out at the moment is probably going to be:
	offline build the tree,
	take all the dashboard resulting source.
		including what gets installed in /usr/local. :(
	put it in a blob
	put the blob in a FreeBSD port where I fetch the blob
	make a package from that.
and then we have net/ceph-dashboard. :(
I did not mention that I need to do this for 2-3 releases 8-|

>> Suggest renaming it to simpledash or dashboard_v1 and keep it in the
>> tree.
> 
> Unfortunately, keeping v1 is not as simple as moving the dashboard to
> a separate directory (unless we leave it hanging as dead code).
> Dashboard_v2 completely replaces dashboard_v1, and that also means
> unit test, QA suites, and references in common files (install-deps.sh,
> CMakeLists.txt, ceph.spec.in, debian/*, do_freebsd.sh, vstart.sh,
> etc.).
> 
> My concern is that properly keeping both ones would go beyond a
> long-but-mostly-clean cherry-picking. It'd involve Luminous actively
> diverging from master, which might burden other backports with
> manual/creative conflict-solving.

Yes, I understand the concerns. But mine are not less complicated.
And especially if all the parts of v1 are also in v2, it requires "just" 
a smart division of tests ao. So that v1 can be tested as a subset.
I know easier said then done.

--WjW

> KR,
> 
> Ernesto
> 
> On Wed, Aug 22, 2018 at 12:43 PM Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
>>
>> On 22/08/2018 12:16, Ernesto Puerta wrote:
>>> [sent both to ceph-devel and ceph-users lists, as it might be of
>>> interest for both audiences]
>>>
>>> Hi all,
>>>
>>> This e-mail is just to announce the WIP on backporting dashboard_v2
>>> (http://docs.ceph.com/docs/master/mgr/dashboard/) from master to
>>> Luminous release.
>>>
>>> The ultimate goal for this backport is to replace dashboard_v1 in
>>> Luminous and provide, **as much as possible**, (see note below) a
>>> level of functionality on a par with master's (i. e.: RBD and RGW
>>> management, HTTPS support, User Management, Role Based Access Control,
>>> Grafana integration, SSO, etc.).
>>
>> If done so, I would prefer to also keep the old "simple" Dashboard.
>> Reason for that is the ease of portability.
>>
>> The old dashboard does not need any package fetch while
>> building/installing. Something that is not very handy when building
>> FreeBSD packages. And I haven't gotten around to determining how to get
>> around that.
>>
>> Next to that: that dashboard is "simple". Something I really like, but
>> that is perhaps personal.
>>
>> Suggest renaming it to simpledash or dashboard_v1 and keep it in the tree.
>>
>> Thanx,
>> --WjW
>>
