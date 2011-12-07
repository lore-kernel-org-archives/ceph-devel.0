From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Cannot mount ceph filesystem: error 5 (Input/Output error)
Date: Wed, 7 Dec 2011 10:00:16 -0800
Message-ID: <CAORUGqDkyTJUWgj-0knXsfYxFC5izi703L=ASsPhigAXY0WZmA@mail.gmail.com>
References: <4366451.BU1d1YAr76@pc10> <3826746.5bRf3lS2YZ@tolkien>
 <CAF3hT9DSf5Xaw00PUFHp5OtGAabka+Wc6H4vVkK24PJGNizd4Q@mail.gmail.com> <1871670.5qvOuPR13S@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59982 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab1LGSAj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 13:00:39 -0500
Received: by eekd41 with SMTP id d41so740791eek.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2011 10:00:37 -0800 (PST)
In-Reply-To: <1871670.5qvOuPR13S@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Dec 7, 2011 at 06:38, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Dienstag, 6. Dezember 2011, 11:51:45 schrieben Sie:
>> PG = "placement group". When placing data in the cluster, objects are
>> mapped into PGs, and those PGs are mapped onto OSDs.
>
> How does the Object->PG mapping look like, do you map more than one object on
> one PG, or do you sometimes map an object to more than one PG? How about the
> mapping of PGs to OSDs, does one PG belong to exactly one OSD?
>
> Does one PG represent a fixed amount of storage space?

Many objects map to one PG.

Each object maps to exactly one PG.

One PG maps to a single list of OSDs, where the first one in the list
is the primary and the rest are replicas.

Many PGs can map to one OSD.

A PG represents nothing but a grouping of objects; you configure the
number of PGs you want  (see
http://ceph.newdream.net/wiki/Changing_the_number_of_PGs ), number of
OSDs * 100 is a good starting point, and all of your stored objects
are pseudo-randomly evenly distributed to the PGs. So a PG explicitly
does NOT represent a fixed amount of storage; it represents 1/pg_num
'th of the storage you happen to have on your OSDs.

Ignoring the finer points of CRUSH and custom placement, it goes
something like this in pseudocode:

locator = object_name
obj_hash = hash(locator)
pg = obj_hash % num_pg
osds_for_pg = crush(pg)  # returns a list of osds
primary = osds_for_pg[0]
replicas = osds_for_pg[1:]

If you want to understand the crush() part in the above, imagine a
perfectly spherical datacenter in a vacuum ;) that is, if all osds
have weight 1.0, and there is no topology to the data center (all OSDs
are on the top level), and you use defaults, etc, it simplifies to
consistent hashing; you can think of it as:

def crush(pg):
    all_osds = ['osd.0', 'osd.1', 'osd.2', ...]
    result = []
    # size is the number of copies; primary+replicas
    while len(result) < size:
        r = get_random_number()
        chosen = all_osds[ r % len(all_osds) ]
        if chosen in result:
            # osd can be picked only once
            continue
        result.append(chosen)
    return result
