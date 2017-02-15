From: Noah Watkins <noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Passing LUA script via python rados execute
Date: Wed, 15 Feb 2017 23:41:20 +0000
Message-ID: <CAB2gnbUqmZk2aPonmmJMu-h4J+pEMZKwMPRT8auTivD3Hfd30A@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1858232537=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz-ImYt9qTNe79BDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1858232537==
Content-Type: multipart/alternative; boundary=94eb2c116a3a53281105489a38fc

--94eb2c116a3a53281105489a38fc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Nick,

First thing to note is that in Kraken that object classes not whitelisted
need to be enabled explicitly. This is in the Kraken release notes (
http://docs.ceph.com/docs/master/release-notes/):

tldr: add 'osd class load list =3D *' and 'osd class default list =3D *' to
ceph.conf.

- The =E2=80=98osd class load list=E2=80=99 config option is a list of obje=
ct class names
that the OSD is permitted to load (or =E2=80=98*=E2=80=99 for all classes).=
 By default it
contains all existing in-tree classes for backwards compatibility.

- The =E2=80=98osd class default list=E2=80=99 config option is a list of o=
bject class
names (or =E2=80=98*=E2=80=99 for all classes) that clients may invoke havi=
ng only the =E2=80=98*=E2=80=99,
=E2=80=98x=E2=80=99, =E2=80=98class-read=E2=80=99, or =E2=80=98class-write=
=E2=80=99 capabilities. By default it contains
all existing in-tree classes for backwards compatibility. Invoking classes
not listed in =E2=80=98osd class default list=E2=80=99 requires a capabilit=
y naming the
class (e.g. =E2=80=98allow class foo=E2=80=99).

I suspect that will resolve the issue.

If you've done that and it still doesn't work then the next thing I'd
suggest is creating the target object before running the command.
Operations on objects that don't exist sometimes seem non-intuitive to me.

Let me know if that doesn't work and we can look at debugging further.

Thanks,
- Noah

On Wed, Feb 15, 2017 at 1:11 PM Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org> wrote:

Hi Noah,

I'm trying to follow your example where you can pass a LUA script as json
when calling the rados execute function in Python. However I'm getting a
rados permission denied error saying its failed to read the test object I
have placed on the pool.

I have also tried calling the cls_hello object class and this works, so I
believe its something to do with the LUA functionality that's causing it to
bomb out. This is running on Kraken.

Any ideas would be gratefully received.

Nick

Ie
print json.dumps(cmd)
ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps(cmd))

Outputs
python radoslua.py --object-name=3Dtest --pool=3Drbd
{"handler": "upper", "script": "\n function upper(input, output)\n
input_str =3D input:str()\n upper_str =3D string.upper(input_str)\n
output:append(upper_str)\n end\n cls.register(upper)\n "}
Traceback (most recent call last):
File "radoslua.py", line 47, in <module>
ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps(cmd))
File "rados.pyx", line 451, in rados.requires.wrapper.validate_func
(/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/rados.=
c
:4439)
File "rados.pyx", line 2657, in rados.Ioctx.execute
(/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/rados.=
c
:34056)
rados.PermissionError: Ioctx.read(rbd): failed to read test

--94eb2c116a3a53281105489a38fc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Nick,<br><br>First thing to note is that in Kraken that=
 object classes not whitelisted need to be enabled explicitly. This is in t=
he Kraken release notes (<a href=3D"http://docs.ceph.com/docs/master/releas=
e-notes/">http://docs.ceph.com/docs/master/release-notes/</a>):<div><br></d=
iv><div>tldr: add &#39;osd class load list =3D *&#39; and &#39;osd class de=
fault list =3D *&#39; to ceph.conf.</div><div><br>- The =E2=80=98osd class =
load list=E2=80=99 config option is a list of object class names that the O=
SD is permitted to load (or =E2=80=98*=E2=80=99 for all classes). By defaul=
t it contains all existing in-tree classes for backwards compatibility.<br>=
<br>- The =E2=80=98osd class default list=E2=80=99 config option is a list =
of object class names (or =E2=80=98*=E2=80=99 for all classes) that clients=
 may invoke having only the =E2=80=98*=E2=80=99, =E2=80=98x=E2=80=99, =E2=
=80=98class-read=E2=80=99, or =E2=80=98class-write=E2=80=99 capabilities. B=
y default it contains all existing in-tree classes for backwards compatibil=
ity. Invoking classes not listed in =E2=80=98osd class default list=E2=80=
=99 requires a capability naming the class (e.g. =E2=80=98allow class foo=
=E2=80=99).<div><br></div><div>I suspect that will resolve the issue.</div>=
<div><br></div><div>If you&#39;ve done that and it still doesn&#39;t work t=
hen the next thing I&#39;d suggest is creating the target object before run=
ning the command. Operations on objects that don&#39;t exist sometimes seem=
 non-intuitive to me.<br></div><div><br></div><div>Let me know if that does=
n&#39;t work and we can look at debugging further.</div><div><br></div><div=
>Thanks,</div><div>- Noah</div><div><br>On Wed, Feb 15, 2017 at 1:11 PM Nic=
k Fisk &lt;<a href=3D"mailto:nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org">nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org</a>&gt; wrote=
:<br><br>Hi Noah,<br> <br> I&#39;m trying to follow your example where you =
can pass a LUA script as json<br> when calling the rados execute function i=
n Python. However I&#39;m getting a<br> rados permission denied error sayin=
g its failed to read the test object I<br> have placed on the pool.<br> <br=
> I have also tried calling the cls_hello object class and this works, so I=
<br> believe its something to do with the LUA functionality that&#39;s caus=
ing it to<br> bomb out. This is running on Kraken.<br> <br> Any ideas would=
 be gratefully received.</div><div> <br> Nick<br> <br> Ie<br> print json.du=
mps(cmd)<br> ret, data =3D ioctx.execute(&#39;test&#39;, &#39;lua&#39;, &#3=
9;eval_json&#39;, json.dumps(cmd))<br> <br> Outputs<br> python radoslua.py =
--object-name=3Dtest --pool=3Drbd<br> {&quot;handler&quot;: &quot;upper&quo=
t;, &quot;script&quot;: &quot;\n      function upper(input, output)\n<br> i=
nput_str =3D input:str()\n        upper_str =3D string.upper(input_str)\n<b=
r> output:append(upper_str)\n      end\n      cls.register(upper)\n  &quot;=
}<br> Traceback (most recent call last):<br>   File &quot;radoslua.py&quot;=
, line 47, in &lt;module&gt;<br>     ret, data =3D ioctx.execute(&#39;test&=
#39;, &#39;lua&#39;, &#39;eval_json&#39;, json.dumps(cmd))<br>   File &quot=
;rados.pyx&quot;, line 451, in rados.requires.wrapper.validate_func<br> (/t=
mp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/rados.c<b=
r> :4439)<br>   File &quot;rados.pyx&quot;, line 2657, in rados.Ioctx.execu=
te<br> (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex=
/rados.c<br> :34056)<br> rados.PermissionError: Ioctx.read(rbd): failed to =
read test<br></div></div></div>

--94eb2c116a3a53281105489a38fc--

--===============1858232537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1858232537==--
