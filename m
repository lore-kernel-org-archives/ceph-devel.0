From: Ross David Turk <ross-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph Developer Summit
Date: Mon, 22 Apr 2013 10:40:07 -0700
Message-ID: <C884B3E9-1F1F-40FC-A328-5836B12D1209@inktank.com>
References: <F54938FA-1070-4BF6-9E7D-0C0036F92384@inktank.com>
	<51737798.8030009@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51737798.8030009-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Hi Loic!

I totally agree.  I've actually set up an etherpad, but haven't had a =

chance to tell anyone yet!  We should add one to each blueprint before =

the summit begins.  You can find the etherpad here:

http://pad.ceph.com

I wrote a quick dekiscript plugin that embeds an etherpad inside a =

wiki page.  If you include this tag in your wiki page, it will embed a =

pad with the same name as the Wiki page ID:

  {{ etherpad{} }}

If you want to specify a pad name, use this instead:

  {{ etherpad{ name: "foo" } }}

Let me know if it works for you!

Cheers,
Ross

 =

On Apr 20, 2013, at 10:22 PM, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org> wrote:

> Hi Ross,
> =

> It would be convenient to discuss the implementation of blueprints using =
and etherpad during the summit. I'm thinking
> =

> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as=
_a_storage_backend#Coding_tasks
> =

> for instance. Although a wiki is convenient for discussing before the sum=
mit, an etherpad is better during the summit, IMHO. =

> =

> What do you think ?
> =

> On 04/12/2013 03:27 AM, Ross David Turk wrote:
>> =

>> Hi, everyone!
>> =

>> I'm pleased to announce that we have begun preparations for the first =

>> Ceph Developer Summit. This summit is where planning for the upcoming =

>> Dumpling release will happen, and attendance is open to all. It will be =

>> virtual (IRC, etherpad, video conference), so you won't even have to =

>> get on an airplane! We're targeting May 6.
>> =

>> Between now and then, we're gathering blueprints for new Ceph features! =

>> A blueprint is a document that describes work someone intends to do, =

>> usually reserved for larger features that require discussion. If =

>> there's a feature you think Ceph should have, we encourage you to write =

>> your thoughts and plans in a blueprint. Then make sure to attend the =

>> summit to discuss its implementation with others in the Ceph community.
>> =

>> For more details, take a look at Patrick's blog post on ceph.com:
>> =

>> http://ceph.com/events/ceph-developer-summit/
>> =

>> Blueprints are currently being accepted at the Ceph wiki. On the front =

>> page, at the bottom, there's a button to create a new one.
>> =

>> Oh! Yeah! There's a wiki now. It's kind of bare-bones at the moment, as =

>> most wikis are when they first enter the world, but it anxiously awaits =

>> your content. Log in with your OpenID credentials and pick a username =

>> to get started. If you're having trouble, or have feedback, your words =

>> are always welcome at community-Qp0mS5GaXlThvxM+mQhndA@public.gmane.org
>> =

>> http://wiki.ceph.com
>> =

>> Best,
>> Ross
>> =

>> --
>> Ross Turk
>> Community, Inktank
>> =

>> @rossturk @inktank @ceph
>> =

>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> =

> -- =

> Lo=EFc Dachary, Artisan Logiciel Libre
> =



--
Ross Turk
Community, Inktank

@rossturk @inktank @ceph
