input metauml;
beginfig(1);
    Class.Users("Users")
    	("Email")("nick","password","name","surname","date of birth","address","zipcode","date of sign up");
    Class.Beverages("Beverages")
    	("name","firm")("amount in stock","price per unit","container","category");
    Class.Crates("Crates")
    	("id")("name","amount per crate","refund","crate");
    Class.Containers("Containers")
    	("id")("name","amout per unit in L","refund","crate");
    Class.Orders("Orders")
    	("email","date")("id","service");
    Class.BoughtGoods("BoughtGoods")
    	("id")(,"beverage","crate","amount");
    Class.Categories("Categories")
    	("name")();

Users.nw = (0,0);
Beverages.nw = Users.ne + (-100,0);
Containers.nw = Beverages.ne + (20,0);
Crates.nw = Containers.ne + (20,0);
Orders.nw = Beverages.sw + (0,40);
BoughtGoods.ne = Beverages.se + (0,40);
Categories.s = Beverages.n + (-20,0);


    %Beverages.w = Users.ne + (20, );
    %Crates.w = Beverages.ne + (20, -5);
    %Containers.nw = Crates.se + (20, 0);
    %Orders.n = Beverages.se + (0, 40);
    %BoughtGoods.n = Orders.s + (5, 40);

    drawObjects(Users, Beverages, Crates, Containers, Orders, BoughtGoods, Categories);

    clink(association)(Containers,Crates);
    clink(association)(Beverages,Containers);
    clink(association)(Orders,Users);
    clink(association)(Orders,BoughtGoods);
    clink(association)(BoughtGoods,Beverages);
    clink(association)(Categories,Beverages);

endfig;
end



