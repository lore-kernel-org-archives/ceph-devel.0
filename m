From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Braindump: path names, partition labels, FHS, auto-discovery
Date: Tue, 27 Mar 2012 11:21:27 -0700
Message-ID: <CAORUGqBrQKWx1SxbtaY5Wx7c8Go-xyV8j6sUhW0wi+wJYrhiAw@mail.gmail.com>
References: <CAORUGqB-XXXt3Gdx6xdKupg+dwC7XMGptg-K_2QTmn4ybcK+Qg@mail.gmail.com>
 <1331114101.19173.34.camel@squire.doc.ic.ac.uk> <Pine.LNX.4.64.1203071240550.32072@cobra.newdream.net>
 <loom.20120319T094436-306@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54074 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab2C0SVs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 14:21:48 -0400
Received: by pbcun15 with SMTP id un15so530112pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 11:21:48 -0700 (PDT)
In-Reply-To: <loom.20120319T094436-306@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: ceph-devel@vger.kernel.org

On Mon, Mar 19, 2012 at 02:21, Bernard Grymonpon <bernard@openminds.be>=
 wrote:
> As I've been constructing some cookbooks to setup a default cluster, =
this is
> what I bumped into:
>
> - the numbering (0, 1, ...) of the OSDs and their need to keep the sa=
me number
> =C2=A0throughout the lifetime of the cluster is a bit a hassle. Each =
OSD needs to
> =C2=A0have a complete view of all the components of the cluster befor=
e it can
> =C2=A0determine it's own ID. A random, auto-generated UUID would be n=
ice (I
> =C2=A0currently solved this by assigning each cluster a global "clust=
ername", and
> =C2=A0search the chef server for all nodes, look for the highest inde=
xed OSDs, and
> =C2=A0increment this to determine the new OSD's index - there must be=
 a better
> =C2=A0way).

That's why you ask the monitors to assign you one:
https://github.com/ceph/ceph-cookbooks/blob/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/recipes/bootstrap_osd.rb#L47

As far as I know, chef does NOT provide the necessary atomicity to
reliably allocate unique ids.

> - the configfile needs to be the same on all hosts - which is only pa=
rtially
> =C2=A0true. From my point of view, a OSD should only have some way of=
 contacting
> =C2=A0one mon, which would inform the OSD of the cluster layout. So, =
only the
> =C2=A0mon-info should be there (together with the info for the OSD it=
self,
> =C2=A0obviously)

Can't rely on a single mon, that'd the a single point of failure.

The only thing the config really needs is the monitor locations. I
expect the rest of this to slowly go away, as we improve the defaults
in the code and the cookbook:

https://github.com/ceph/ceph-cookbooks/blob/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/templates/default/ceph.conf.erb

> - there is a chicken-egg problem in the authentication of a osd to th=
e mon. An
> =C2=A0OSD should have permission to join the mon, for which we need t=
o add the OSD
> =C2=A0to the mon. As chef works on the node, and can't trigger stuff =
on other
> =C2=A0nodes, the node that will hold the OSD needs some way of authen=
ticating
> =C2=A0itself to the mon (I solved this by storing the "client.admin" =
secret on the
> =C2=A0mon-node, and then pulling this from there on the osd node, and=
 using it to
> =C2=A0register myself to the mon. It is like putting a copy of your h=
omekey on
> =C2=A0your front door...). I see no obvious solution here.

I use a "bootstrap-osd" key that can create new OSDs and authorize
keys for them. It's less powerful than client.admin.

https://github.com/ceph/ceph-cookbooks/blob/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/recipes/single_mon.rb#L49

https://github.com/ceph/ceph-cookbooks/blob/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/recipes/bootstrap_osd.rb#L20

> - the current (debian) start/stop scripts are a hassle to work with, =
as chef
> =C2=A0doesn't understand the third parameter (/etc/init.d/ceph start =
mon.0). Each
> =C2=A0mon / osd / ... should have its own start/stop script.

The cookbook uses upstart jobs, and runs an instance per osd id etc.

https://github.com/ceph/ceph-cookbooks/blob/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/templates/default/upstart-ceph-osd.conf.erb
https://github.com/ceph/ceph-cookbooks/tree/1d381a3e1dd767c4c8ab6688782=
85b545a70846a/ceph/templates/default

> - there should be some way to ask a local running OSD/MON for its sta=
tus,
> =C2=A0without having to go through the monitor-nodes. Sort of "ceph-l=
ocal-daemon
> =C2=A0--uuid=3Dxxx --type=3Dmon status", which would inform us if it =
is running,
> =C2=A0healthy, part of the cluster, lost in space...

That'd be the "admin socket". It's unfortunately not well documented cu=
rrently.

> - growing the cluster bit by bit would be ideal, this is how chef wor=
ks (it
> =C2=A0handles node per node, not a bunch of nodes in one go)

The cookbook handles this, with some limitations that will be removed
once we have resources to work on it again.

> - ideal, there would be a automatic-crushmap-expansion command which =
would add
> =C2=A0a device to an existing crushmap (or remove one). Now, the crus=
hmap needs to
> =C2=A0be reconstructed completely, and if your numbering changes some=
how, you're
> =C2=A0screwed. Ideal would be "take the current crushmap and add OSD =
with uuid
> =C2=A0xxx" - "take the current crushmap and remove OSD xxx"

Exists already.

> Just my thoughts! I've been following the ceph project for a while no=
w, set up
> a couple of test clusters in the past and the last two weeks, and mad=
e the
> cookbooks to make my life easier (and bumped in a lot of Ops-trouble =
doing
> this...).

To summarize:

Status of the cookbook at https://github.com/ceph/ceph-cookbooks is:

- it assumes you only run a single monitor
- it assumes you run 1 osd per node, as a subdirectory of /srv

Both of these restrictions will be eventually lifted, that was just to
get started.

Right now, I know we have one admin looking to lift the "1 osd per
node" limitation (he's ok doing mons manually), but other than that
I'm the only person who has put time into the cookbooks, and I'm
currently busy setting up our automated test infrastructure. We're
hiring Chef devopsy people, come help us!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
