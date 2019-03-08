From: Herbert Alexander Faleiros <herbert-b2jWxOBV4z0IdKJ7tpkyPg@public.gmane.org>
Subject: Re: Failed to repair pg
Date: Fri, 8 Mar 2019 09:52:24 -0300
Message-ID: <20190308125224.GA92844@registro.br>
References: <20190307163755.GV6574@registro.br>
 <20190307173242.GB6574@registro.br>
 <ab4615ef-6064-52b6-4442-faa45cbc84f5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ab4615ef-6064-52b6-4442-faa45cbc84f5-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

thanks for the answer.

On Thu, Mar 07, 2019 at 07:48:59PM -0800, David Zafman wrote:
> See what results you get from this command.
> =

> # rados list-inconsistent-snapset 2.2bb --format=3Djson-pretty
> =

> You might see this, so nothing interesting.=A0 If you don't get json, the=
n =

> re-run a scrub again.
> =

> {
>  =A0=A0=A0 "epoch": ######,
>  =A0=A0=A0 "inconsistents": []
> }

# rados list-inconsistent-snapset 2.2bb --format=3Djson-pretty
{
    "epoch": 485065,
    "inconsistents": [
        {
            "name": "rbd_data.dfd5e2235befd0.000000000001c299",
            "nspace": "",
            "locator": "",
            "snap": 326022,
            "errors": [
                "headless"
            ]
        },
        {
            "name": "rbd_data.dfd5e2235befd0.000000000001c299",
            "nspace": "",
            "locator": "",
            "snap": "head",
            "snapset": {
                "snap_context": {
                    "seq": 327360,
                    "snaps": []
                },
                "head_exists": 1,
                "clones": []
            },
            "errors": [
                "extra_clones"
            ],
            "extra clones": [
                326022
            ]
        }
    ]
}

> I don't think you need to do the remove-clone-metadata because you got =

> "unexpected clone" so I think you'd get "Clone 326022 not present"
> =

> I think you need to remove the clone object from osd.12 and osd.80.=A0 Fo=
r =

> example:
> =

> # ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-12/ =

> --journal-path /dev/sdXX --op list rbd_data.dfd5e2235befd0.000000000001c2=
99
> =

> ["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snap=
id":-2,"hash":########,"max":0,"pool":2,"namespace":"","max":0}]
> ["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snap=
id":326022,"hash":#########,"max":0,"pool":2,"namespace":"","max":0}]
> =

> Use the json for snapid 326022 to remove it.
> =

> # ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-12/ =

> --journal-path /dev/sdXX =

> '["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","sna=
pid":326022,"hash":#########,"max":0,"pool":2,"namespace":"","max":0}]' =

> remove

# ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-80/ --journal-pa=
th /dev/sda1 --op list rbd_data.dfd5e2235befd0.000000000001c299 --pgid 2.2bb
["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snapid=
":326022,"hash":3420345019,"max":0,"pool":2,"namespace":"","max":0}]
["2.2bb",{"oid":"rbd_data.dfd5e2235befd

I added --pgid 2.2bb because it is taking to long to finish.

# ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-80/ --journal-pa=
th /dev/sda1 '["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","k=
ey":"","snapid":326022,"hash":3420345019,"max":0,"pool":2,"namespace":"","m=
ax":0}]' remove
remove #2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986#

osd.12 was a slight diferent because it is bluestore:

# ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-12/ --op list rb=
d_data.dfd5e2235befd0.000000000001c299 --pgid 2.2bb
["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snapid=
":326022,"hash":3420345019,"max":0,"pool":2,"namespace":"","max":0}]
["2.2bb",{"oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snapid=
":-2,"hash":3420345019,"max":0,"pool":2,"namespace":"","max":0}]

# ceph-objectstore-tool --data-path /var/lib/ceph/osd/ceph-12/ '["2.2bb",{"=
oid":"rbd_data.dfd5e2235befd0.000000000001c299","key":"","snapid":326022,"h=
ash":3420345019,"max":0,"pool":2,"namespace":"","max":0}]' remove
remove #2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986#

But nothing changed, so I tried to repair the pg again and from osd.36
I got now:

2019-03-08 09:09:11.786038 7f920c40d700 -1 log_channel(cluster) log [ERR] :=
 2.2bb shard 36 soid 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:=
4f986 : candidate size 0 info size 4194304 mismatch
2019-03-08 09:09:11.786041 7f920c40d700 -1 log_channel(cluster) log [ERR] :=
 2.2bb soid 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 : f=
ailed to pick suitable object info
2019-03-08 09:09:11.786182 7f920c40d700 -1 log_channel(cluster) log [ERR] :=
 repair 2.2bb 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 :=
 on disk size (0) does not match object info size (4194304) adjusted for on=
disk to (4194304)
2019-03-08 09:09:11.786191 7f920c40d700 -1 log_channel(cluster) log [ERR] :=
 repair 2.2bb 2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 :=
 is an unexpected clone
2019-03-08 09:09:11.786213 7f920c40d700 -1 osd.36 pg_epoch: 485254 pg[2.2bb=
( v 485253'15080921 (485236'15079373,485253'15080921] local-lis/les=3D48525=
1/485252 n=3D3836 ec=3D38/38 lis/c 485251/485251 les/c/f 485252/485252/0 48=
5251/485251/484996) [36,12,80] r=3D0 lpr=3D485251 crt=3D485253'15080921 lco=
d 485252'15080920 mlcod 485252'15080920 active+clean+scrubbing+deep+inconsi=
stent+repair snaptrimq=3D[5022c~1,50230~1]] _scan_snaps no clone_snaps for =
2:dd4a7bd3:::rbd_data.dfd5e2235befd0.000000000001c299:4f986 in 4fec0=3D[]:{}

And:

# rados list-inconsistent-snapset 2.2bb --format=3Djson-pretty
{
    "epoch": 485251,
    "inconsistents": []
}

Now I have:

HEALTH_ERR 5 scrub errors; Possible data damage: 1 pg inconsistent
OSD_SCRUB_ERRORS 5 scrub errors
PG_DAMAGED Possible data damage: 1 pg inconsistent
    pg 2.2bb is active+clean+inconsistent, acting [36,12,80]

Jumped from 3 to 5 scrub errors now.

Any clues?

Thanks again,

--
Herbert
