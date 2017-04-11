From: Ricardo Dias <rdias@suse.com>
Subject: Re: multiple cherrypys in ceph-mgr modules stomp on each other
Date: Tue, 11 Apr 2017 12:17:03 +0100
Message-ID: <458F8704-74E1-4446-BAAC-4BEE1366EBC7@suse.com>
References: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_649C7363-D7DB-4CF9-85C5-C6917631F1DC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57147 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdDKLR0 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 11 Apr 2017 07:17:26 -0400
In-Reply-To: <ded84b4f-d13b-d2f0-6d40-fe34d6905adb@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_649C7363-D7DB-4CF9-85C5-C6917631F1DC
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi,

What if ceph-mgr modules could actually depend on each other. That way,
we could have a single cherrypy module and other modules could depend
on the cherrypy module.
The cherrypy module would redirect requests to the corresponding module.
Would that be an option?

I know nothing about the ceph-mgr architecture, so ignore my suggestion if
does not make sense at all.

Ricardo Dias

> On 11 Apr 2017, at 11:41, Tim Serong <tserong@suse.com> wrote:
> 
> Hi All,
> 
> We have a problem using cherrypy in mgr modules.  Specifically, multiple
> modules that use cherrypy stomp on each other.  I discovered this while
> playing with John's guilolz experiment
> (https://github.com/ceph/ceph/pull/13725).
> 
> Both rest and guilolz modules follow this pattern:
> 
>  cherrypy.config.update({'server.socket_port': ....})
>  cherrypy.tree.graft(...)  # or cherrypy.tree.mount(...)
>  cherrypy.engine.start()
>  cherrypy.engine.block()
> 
> So:
> 
> - They're both first setting the port to listen on globally.
> - They both eat the whole web namespace (graft/mount).
> - They both call cherrypy.engine.start() to start the server.
> 
> In each of the above cases, the first module loaded will win and the
> other won't (or, it might be racey and you'll kinda get a mix?).  For
> example, the second call to cherrypy.engine.start() fails complaining it
> can't be called more than once from the same thread.
> 
> I'm not sure how best to deal with this.  Assuming we *do* want it to be
> possible for multiple modules that provide a web service to be loaded
> simultaneously, we need to:
> 
> - not set the port globally.
> - not stomp on each others namespaces.
> - only call cherrypy.engine.start() once.
> 
> You can have multiple cherrypy servers listening on different ports, so
> that gets us part of the way there, e.g.:
> 
>  from cherrypy._cpserver import Server
>  server = Server()
>  server.socket_port = .... # whatever
>  server.subscribe()
> 
> But, this doesn't fix the namespace eating problem.  That might be
> doable with cherrypy virtualhosts
> (http://tools.cherrypy.org/wiki/VirtualHosts), but I haven't
> experimented further with that yet.
> 
> Also, those subscribe()s have to happen before the
> cherrypy.engine.start() call or they have no effect.  One way to do that
> would be to have some magic cherrypy module which is always loaded last
> to start the engine, but that might be ugly.
> 
> Another option might be to have a separate python interpreter per module
> (can't stomp on each other then, right?) but that might be too resource
> intensive.
> 
> Thoughts?
> 
> Thanks,
> 
> Tim
> --
> Tim Serong
> Senior Clustering Engineer
> SUSE
> tserong@suse.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--Apple-Mail=_649C7363-D7DB-4CF9-85C5-C6917631F1DC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJY7LsxAAoJEHQ5DFeb03to1X4H/A6Sk9iotaJP6tN94/YWOglD
vnsTyL2uXud8dQc6ThUiQNWIFuBvXsu8ixyN9c3H2cz47iu0jmvlTtI7inkEd++y
0vfWoaWhYpLEFcHZmazfaioVzQvASpNkSMzo9WCs1Jfz+nnLo0jIHStAbTUmYyRC
wCR4HjKEkVTvCUEn5OsuEv5hx6AAFka00F7ouhngR+ABqm2E4ggkFO9X2Bqr5z+r
crgFaHdVO803Qpjyc2ebmS8diQaH62Sa268KfsshF4T4Ia+0UBfMaxeqh55P9fk4
EmzIz7CSgo1Q+tl6bHimGo4JFIWCUua5rTkWNNjdol4/goCMruNMHCEtXdr+WU8=
=VUtX
-----END PGP SIGNATURE-----

--Apple-Mail=_649C7363-D7DB-4CF9-85C5-C6917631F1DC--
