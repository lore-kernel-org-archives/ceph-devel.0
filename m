From: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Subject: Re: Passing LUA script via python rados execute
Date: Tue, 21 Feb 2017 21:45:23 -0000
Message-ID: <10037c78.AEEAIIaNAnsAAAAAAAAAAEtrDcsAADNJBWwAAAAAAACRXwBYrLT9@mailjet.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
	<CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
	<3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
	<CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
	<1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
	<CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
	<3a5eb209.AEEAIECau6cAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYp3rL@mailjet.com>
	<CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com>
	<CA+2bHPYgFkRbNwc8b1aLcTX+0-=DecM1m3BV5ssjKFmBYBmo2w@mail.gmail.com>
	<10499347-8c11-83fb-9778-e95049668c6c@redhat.com>
Reply-To: nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <10499347-8c11-83fb-9778-e95049668c6c-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-gb
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Josh Durgin' <jdurgin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Patrick Donnelly' <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Noah Watkins' <noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'ceph-devel' <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> 
> On 02/19/2017 12:15 PM, Patrick Donnelly wrote:
> > On Sat, Feb 18, 2017 at 2:55 PM, Noah Watkins <noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> >> The least intrusive solution is to simply change the sandbox to allow
> >> the standard file system module loading function as expected. Then
> >> any user would need to make sure that every OSD had consistent
> >> versions of dependencies installed using something like LuaRocks.
> >> This is simple, but could make debugging and deployment a major
> headache.
> >
> > A locked down require which doesn't load C bindings (i.e. only load
> > .lua files) would probably be alright.
> >
> >> A more ambitious version would be to create an interface for users to
> >> upload scripts and dependencies into objects, and support referencing
> >> those objects as standard dependencies in Lua scripts as if they were
> >> standard modules on the file system. Each OSD could then cache
> >> scripts and dependencies, allowing applications to use references to
> >> scripts instead of sending a script with every request.
> >
> > This is very doable. I imagine we'd just put all of the Lua modules in
> > a flattened hierarchy under a RADOS namespace? The potentially
> > annoying nit in this is writing some kind of mechanism for installing
> > a Lua module tree into RADOS. Users would install locally and then
> > upload the tree through some tool.
> 
> Using rados objects for this is not really feasible. It would be incredibly
> complex within the osd - it involves multiple objects, cache invalidation, and
> has all kinds of potential issues with consistent versioning and atomic
> updates across objects.
> 
> The simple solution of loading modules from the local fs sounds way better
> to me. Putting modules on all osds and reloading the modules or restarting
> the osds seems like a pretty simple deployment model with any configuration
> management system.
> 
> That said, for research purposes you could resurrect something like the
> ability to load modules into the cluster from a client - just store them on the
> local fs of each osd, not in rados objects. This was removed back in 2011:
> 
> https://github.com/ceph/ceph/commit/7c04f81ca16d11fc5a592992a4462b3
> 4ccb199dc
> https://github.com/ceph/ceph/commit/964a0a6e1326d4f773c547655ebb2a5
> c97794268
> 

Thanks Josh. They look like they refer to loading the actual rados classes themselves, whereas I just want the LUA rados class which runs a LUA script passed via JSON, to be able to load extra lua scripts from the local FS. Or have I misunderstood the contents of those commits?

I'm trying to put some examples together for a book and so wanted to try and come up with a more out of the box experience someone could follow. I'm guessing some basic examples in LUA and then come custom rados classes in C++ might be the best approach for this for now?

> Josh
