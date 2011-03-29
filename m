From: Sage Weil <sage@newdream.net>
Subject: Re: librados compound operations
Date: Tue, 29 Mar 2011 09:27:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103290915160.19819@cobra.newdream.net>
References: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
 <AANLkTin9P9UMSmKPmVwMCSBjPMQ6zGKVamzUbQaPmkVJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1446060823-1301416038=:19819"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48069 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab1C2QYV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 12:24:21 -0400
In-Reply-To: <AANLkTin9P9UMSmKPmVwMCSBjPMQ6zGKVamzUbQaPmkVJ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1446060823-1301416038=:19819
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 28 Mar 2011, Colin McCabe wrote:
> On Mon, Mar 28, 2011 at 3:46 PM, Sage Weil <sage@newdream.net> wrote:
> > Below is a patch that wraps the internal Objecter compound ObjectOperat=
ion
> > so that we can send compound operations to the OSDs via librados.
> >
> > The internal ObjectOperationImpl ends up being unnecessary; I just cast=
 it
> > to the internal type directly.
> >
> > One weird thing I noticed is with the constructor. =A0In Rados:: did
> >
> > + =A0 =A0static ObjectOperation *operation_create();
> >
> > and the user then deletes it when they're done (after using it for one =
or
> > more calls to operate() or aio_operate()). =A0Is that the the approach =
we
> > want? =A0Because right above that in the header is
> >
> > =A0 =A0 int ioctx_create(const char *name, IoCtx &pioctx);
> >
>=20
> I second TV's argument that returning a detailed error code is better
> than returning NULL or not-NULL.
>=20
> I also don't like calling conventions that always use dynamic memory
> allocation. Even on a shiny new 16-core system, there is still a
> global mutex around new()/free(). I also like putting stuff on the
> stack and using RAII. (I haven't looked at this new code enough to see
> whether RAII makes sense here though.)

Hmm.  Well, pushing the work into the construct lets you just do=20
something like

  ObjectOperation o;
  o.write_full(bl);
  o.setxattr("foo", bl2);
  int r =3D io_ctx.operate(oid, &o, &outbl);

which is cleaner IMO, but you don't get an error code.  For that, you need=
=20
something like

  ObjectOperation o;
  if (rados.operation_init(o) < 0)
=09...
  o.write_full(bl);
  o.setxattr("foo", bl2);
  int r =3D io_ctx.operate(oid, &o, &outbl);

I prefer the former, myself.

sage


diff --git a/src/include/rados/librados.hpp b/src/include/rados/librados.hp=
p
index 58e1fb6..a44a68a 100644
--- a/src/include/rados/librados.hpp
+++ b/src/include/rados/librados.hpp
@@ -98,6 +98,7 @@ namespace librados
   class ObjectOperation
   {
   public:
+    ObjectOperation();
     ~ObjectOperation();
=20
     void write(uint64_t off, const bufferlist& bl);
@@ -114,7 +115,6 @@ namespace librados
=20
   private:
     ObjectOperationImpl *impl;
-    ObjectOperation(ObjectOperationImpl *impl_) : impl(impl_) {}
     ObjectOperation(const ObjectOperation& rhs);
     ObjectOperation& operator=3D(const ObjectOperation& rhs);
     friend class IoCtx;
@@ -263,8 +263,6 @@ namespace librados
=20
     int ioctx_create(const char *name, IoCtx &pioctx);
=20
-    static ObjectOperation *operation_create();
-
     /* listing objects */
     int pool_list(std::list<std::string>& v);
     int get_pool_stats(std::list<std::string>& v,
diff --git a/src/librados.cc b/src/librados.cc
index 788e1cc..2fd093f 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -2729,9 +2729,10 @@ aio_create_completion(void *cb_arg, callback_t cb_co=
mplete, callback_t cb_safe)
   return new AioCompletion(c);
 }
=20
-librados::ObjectOperation *librados::Rados::operation_create()
+
+librados::ObjectOperation::ObjectOperation()
 {
-  return new librados::ObjectOperation((ObjectOperationImpl *)new ::Object=
Operation);
+  impl =3D (ObjectOperationImpl *)new ::ObjectOperation;
 }
=20
 librados::ObjectOperation::~ObjectOperation()
diff --git a/src/testradospp.cc b/src/testradospp.cc
index 971549a..1caa075 100644
--- a/src/testradospp.cc
+++ b/src/testradospp.cc
@@ -204,12 +204,11 @@ int main(int argc, const char **argv)
   }
=20
   cout << "compound operation..." << std::endl;
-  ObjectOperation *o =3D rados.operation_create();
-  o->write(0, bl);
-  o->setxattr("foo", bl2);
-  r =3D io_ctx.operate(oid, o, &bl2);
+  ObjectOperation o;
+  o.write(0, bl);
+  o.setxattr("foo", bl2);
+  r =3D io_ctx.operate(oid, &o, &bl2);
   cout << "operate result=3D" << r << std::endl;
-  delete o;
=20
   cout << "iterating over objects..." << std::endl;
   int num_objs =3D 0;
--557981400-1446060823-1301416038=:19819--
