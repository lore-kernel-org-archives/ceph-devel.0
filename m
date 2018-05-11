From: =?UTF-8?Q?Marc_Sch=c3=b6chlin?= <ms-aJA5TdoZkU0dnm+yROfE0A@public.gmane.org>
Subject: Re: RBD Cache and rbd-nbd
Date: Fri, 11 May 2018 09:59:11 +0200
Message-ID: <de7be619-2da0-7f4f-08cf-aafb80bffeb9@256bit.org>
References: <f57c4834-517e-0c0e-7496-831689327bac@256bit.org>
 <CA+aFP1BYyE-opsc8eLH79A8EK-2N0cv_qjah788dKdOYLx7ZYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476726105933875711=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+aFP1BYyE-opsc8eLH79A8EK-2N0cv_qjah788dKdOYLx7ZYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1476726105933875711==
Content-Type: multipart/alternative;
 boundary="------------CEDDA74766016631194C9E50"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CEDDA74766016631194C9E50
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Jason,

thanks for your response.


Am 10.05.2018 um 21:18 schrieb Jason Dillaman:

>> If i configure caches like described at
>> http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/, are there dedi=
cated
>> caches per rbd-nbd/krbd device or is there a only a single cache area.=

> The librbd cache is per device, but if you aren't performing direct
> IOs to the device, you would also have the unified Linux pagecache on
> top of all the devices.
XENServer directly utilizes nbd devices which are connected in my
understanding by blkback (dom-0) and blkfront (dom-U) to the virtual
machines.
In my understanding pagecache is only part of the game if i use data on
mounted filesystems (VFS usage).
Therefore it would be a good thing to use rbd cache for rbd-nbd (/dev/nbd=
X).
>> How can i identify the rbd cache with the tools provided by the operat=
ing
>> system?
> Identify how? You can enable the admin sockets and use "ceph
> --admin-deamon config show" to display the in-use settings.

Ah ok, i discovered that i can gather configuration settings by executing=
:
(xen_test is the identity of the xen rbd_nbd user)

ceph --id xen_test --admin-daemon
/var/run/ceph/ceph-client.xen_test.asok config show | less -p rbd_cache

Sorry, my question was a bit unprecice: I was searching for usage
statistics of the rbd cache.
Is there also a possibility to gather rbd_cache usage statistics as a
source of verification for optimizing the cache settings?

Due to the fact that a rbd cache is created for every device, i assume
that the rbd cache simply part of the rbd-nbd process memory.


>> Can you provide some hints how to about adequate cache settings for a =
write
>> intensive environment (70% write, 30% read)?
>> Is it a good idea to specify a huge rbd cache of 1 GB with a max dirty=
 age
>> of 10 seconds?
> The librbd cache is really only useful for sequential read-ahead and
> for small writes (assuming writeback is enabled). Assuming you aren't
> using direct IO, I'd suspect your best performance would be to disable
> the librbd cache and rely on the Linux pagecache to work its magic.
As described, xenserver directly utilizes the nbd devices.

Our typical workload is originated over 70 percent in database write
operations in the virtual machines.
Therefore collecting write operations with rbd cache and writing them in
chunks to ceph might be a good thing.
A higher limit for "rbd cache max dirty" might be a adequate here.
At the other side our read workload typically reads huge files in
sequential manner.

Therefore it might be useful to do start with a configuration like that:

rbd cache size =3D 64MB
rbd cache max dirty =3D 48MB
rbd cache target dirty =3D 32MB
rbd cache max dirty age =3D 10

What is the strategy of librbd to write data to the storage from
rbd_cache if "rbd cache max dirty =3D 48MB" is reached?
Is there a reduction of io operations (merging of ios) compared to the
granularity of writes of my virtual machines?

Additionally, i would do no non-default settings for readahead on nbd
level to have the possibility to configure this at operating system
level of the vms.

Our operating systems in the virtual machines use currently a readahead
of 256 (256*512 =3D 128KB).
=46rom my point of view it would be a good thing for sequential reads in
big files to increase readahead to a higher value.
We haven't changed the default rbd object size of 4MB - nevertheless it
might be a good thing to increase the readahead to 1024 (=3D512KB) to
decrease read requests by factor of 4for sequential reads.

What do you think about this?

Regards
Marc


--------------CEDDA74766016631194C9E50
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hello Jason,</p>
    <p>thanks for your response.<br>
    </p>
    <br>
    <div class="moz-cite-prefix">Am 10.05.2018 um 21:18 schrieb Jason
      Dillaman:<br>
    </div>
    <br>
    <blockquote type="cite"
cite="mid:CA+aFP1BYyE-opsc8eLH79A8EK-2N0cv_qjah788dKdOYLx7ZYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">If i configure caches like described at
<a class="moz-txt-link-freetext" href="http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/">http://docs.ceph.com/docs/luminous/rbd/rbd-config-ref/</a>, are there dedicated
caches per rbd-nbd/krbd device or is there a only a single cache area.
</pre>
      </blockquote>
      <pre wrap="">
The librbd cache is per device, but if you aren't performing direct
IOs to the device, you would also have the unified Linux pagecache on
top of all the devices.</pre>
    </blockquote>
    XENServer directly utilizes nbd devices which are connected in my
    understanding by blkback (dom-0) and blkfront (dom-U) to the virtual
    machines.<br>
    In my understanding pagecache is only part of the game if i use data
    on mounted filesystems (VFS usage).<br>
    Therefore it would be a good thing to use rbd cache for rbd-nbd
    (/dev/nbdX).<br>
    <blockquote type="cite"
cite="mid:CA+aFP1BYyE-opsc8eLH79A8EK-2N0cv_qjah788dKdOYLx7ZYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <blockquote type="cite">
        <pre wrap="">How can i identify the rbd cache with the tools provided by the operating
system?
</pre>
      </blockquote>
      <pre wrap="">
Identify how? You can enable the admin sockets and use "ceph
--admin-deamon config show" to display the in-use settings.</pre>
    </blockquote>
    <br>
    Ah ok, i discovered that i can gather configuration settings by
    executing:<br>
    (xen_test is the identity of the xen rbd_nbd user)<br>
    <tt><br>
      ceph --id xen_test --admin-daemon
      /var/run/ceph/ceph-client.xen_test.asok config show | less -p
      rbd_cache<br>
      <br>
    </tt>Sorry, my question was a bit unprecice: I was searching for
    usage statistics of the rbd cache.<tt><br>
    </tt>Is there also a possibility to gather rbd_cache usage
    statistics as a source of verification for optimizing the cache
    settings?<tt><br>
      <br>
    </tt>Due to the fact that a rbd cache is created for every device, i
    assume that the rbd cache simply part of the rbd-nbd process memory.<tt><br>
      <br>
      <br>
    </tt>
    <blockquote type="cite"
cite="mid:CA+aFP1BYyE-opsc8eLH79A8EK-2N0cv_qjah788dKdOYLx7ZYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <blockquote type="cite">
        <pre wrap="">Can you provide some hints how to about adequate cache settings for a write
intensive environment (70% write, 30% read)?
Is it a good idea to specify a huge rbd cache of 1 GB with a max dirty age
of 10 seconds?
</pre>
      </blockquote>
      <pre wrap="">
The librbd cache is really only useful for sequential read-ahead and
for small writes (assuming writeback is enabled). Assuming you aren't
using direct IO, I'd suspect your best performance would be to disable
the librbd cache and rely on the Linux pagecache to work its magic.
</pre>
    </blockquote>
    As described, xenserver directly utilizes the nbd devices.<br>
    <br>
    Our typical workload is originated over 70 percent in database write
    operations in the virtual machines.<br>
    Therefore collecting write operations with rbd cache and writing
    them in chunks to ceph might be a good thing.<br>
    A higher limit for "rbd cache max dirty" might be a adequate here.<br>
    At the other side our read workload typically reads huge files in
    sequential manner.<br>
    <br>
    Therefore it might be useful to do start with a configuration like
    that:<br>
    <p><tt class="docutils literal"><span class="pre">rbd</span> <span
          class="pre">cache</span> <span class="pre">size = 64MB<br>
        </span></tt><tt class="docutils literal"><span class="pre">rbd</span>
        <span class="pre">cache</span> <span class="pre">max</span> <span
          class="pre">dirty = 48MB<br>
          rbd cache target dirty = 32MB<br>
          rbd cache max dirty age = 10<br>
        </span></tt></p>
    <p>What is the strategy of librbd to write data to the storage from
      rbd_cache if "rbd cache max dirty = 48MB" is reached?<br>
      Is there a reduction of io operations (merging of ios) compared to
      the granularity of writes of my virtual machines?<br>
    </p>
    <p><span class="docutils literal"><span class="pre">Additionally, i
          would do no non-default settings for readahead on nbd level to
          have the possibility to configure this at operating system
          level of the vms.</span></span></p>
    <p><span class="docutils literal"><span class="pre">Our operating
          systems in the virtual machines use currently a readahead of
          256 (256*512 = 128KB).<br>
          From my point of view it would be a good thing for sequential
          reads in big files to increase readahead to a higher value.<br>
          We haven't changed the default rbd object size of 4MB -
          nevertheless it might be a good thing to increase </span></span><span
        class="docutils literal"><span class="pre">the readahead to 1024
          (=512KB) to decrease read requests by factor of 4</span></span><span
        class="docutils literal"><span class="pre"></span></span><span
        class="docutils literal"><span class="pre"> for sequential
          reads.</span></span><tt class="docutils literal"><span
          class="pre"><br>
        </span></tt></p>
    <p><span class="docutils literal"><span class="pre">What do you
          think about this</span></span><tt class="docutils literal"><span
          class="pre">?<br>
        </span></tt></p>
    Regards<br>
    Marc<br>
    <br>
  </body>
</html>

--------------CEDDA74766016631194C9E50--

--===============1476726105933875711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1476726105933875711==--
